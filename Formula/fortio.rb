class Fortio < Formula
  desc "HTTP and gRPC load testing and visualization tool and server"
  homepage "https://fortio.org/"
  url "https://github.com/fortio/fortio.git",
      :tag      => "v1.3.0",
      :revision => "bf3f2d9ff07ed03ef16be56af20d58dc0300e60f"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    (buildpath/"src/fortio.org/fortio").install buildpath.children
    cd "src/fortio.org/fortio" do
      system "make", "official-build", "OFFICIAL_BIN=#{bin}/fortio",
             "LIB_DIR=#{lib}"
      lib.install "ui/static", "ui/templates"
      prefix.install_metafiles
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fortio version -s")
    begin
      pid = fork do
        exec bin/"fortio", "server", "-http-port", "8080"
      end
      sleep 2
      output = shell_output("#{bin}/fortio load http://localhost:8080/ 2>&1")
      assert_match /^All\sdone/, output.lines.last
    ensure
      Process.kill("SIGTERM", pid)
    end
  end
end
