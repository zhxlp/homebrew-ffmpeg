class Cayley < Formula
  desc "Graph database inspired by Freebase and Knowledge Graph"
  homepage "https://github.com/cayleygraph/cayley"
  url "https://github.com/cayleygraph/cayley/archive/v0.7.5.tar.gz"
  sha256 "4fcc8bf44f775dbbbd6146713f6fbdc80f2d88e2e8b93767f62eb5d635a56739"
  head "https://github.com/google/cayley.git"



  depends_on "bazaar" => :build
  depends_on "dep" => :build
  depends_on "go" => :build
  depends_on "mercurial" => :build

  def install
    ENV["GOPATH"] = buildpath

    (buildpath/"src/github.com/cayleygraph/cayley").install buildpath.children
    cd "src/github.com/cayleygraph/cayley" do
      system "dep", "ensure", "-vendor-only"
      system "go", "build", "-o", bin/"cayley", "-ldflags",
             "-X main.Version=#{version}", ".../cmd/cayley"

      inreplace "cayley_example.yml", "./cayley.db", var/"cayley/cayley.db"
      etc.install "cayley_example.yml" => "cayley.yml"

      (pkgshare/"assets").install "docs", "static", "templates"

      # Install samples
      system "gzip", "-d", "data/30kmoviedata.nq.gz"
      (pkgshare/"samples").install "data/testdata.nq", "data/30kmoviedata.nq"
    end
  end

  def post_install
    unless File.exist? var/"cayley"
      (var/"cayley").mkpath

      # Initialize the database
      system bin/"cayley", "init", "--config=#{etc}/cayley.yml"
    end
  end

  plist_options :manual => "cayley http --assets=#{HOMEBREW_PREFIX}/share/cayley/assets --config=#{HOMEBREW_PREFIX}/etc/cayley.conf"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <dict>
          <key>SuccessfulExit</key>
          <false/>
        </dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/cayley</string>
          <string>http</string>
          <string>--assets=#{opt_pkgshare}/assets</string>
          <string>--config=#{etc}/cayley.conf</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{var}/cayley</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/cayley.log</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/cayley.log</string>
      </dict>
    </plist>
  EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cayley version")
  end
end
