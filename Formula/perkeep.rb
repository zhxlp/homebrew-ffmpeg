class Perkeep < Formula
  desc "Lets you permanently keep your stuff, for life"
  homepage "https://perkeep.org/"
  url "https://github.com/perkeep/perkeep.git",
      :tag      => "0.10",
      :revision => "0cbe4d5e05a40a17efe7441d75ce0ffdf9d6b9f5"
  head "https://github.com/perkeep/perkeep.git"



  depends_on "go" => :build
  depends_on "pkg-config" => :build

  conflicts_with "hello", :because => "both install `hello` binaries"

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/perkeep.org").install buildpath.children
    cd "src/perkeep.org" do
      system "go", "run", "make.go"
      prefix.install_metafiles
    end
    bin.install Dir["bin/*"].select { |f| File.executable? f }
  end

  plist_options :manual => "perkeepd"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>KeepAlive</key>
      <true/>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_bin}/perkeepd</string>
        <string>-openbrowser=false</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
    </dict>
    </plist>
  EOS
  end

  test do
    system bin/"pk-get", "-version"
  end
end
