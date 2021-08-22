require "language/go"

class Websocketd < Formula
  desc "WebSockets the Unix way"
  homepage "http://websocketd.com"
  url "https://github.com/joewalnes/websocketd/archive/v0.3.0.tar.gz"
  sha256 "f59fefdf79d6b99140027b3c58ca77d59bb3c1fa2f15969d7239538b04042b3d"



  depends_on "go" => :build

  go_resource "github.com/gorilla/websocket" do
    url "https://github.com/gorilla/websocket.git",
        :revision => "cdedf21e585dae942951e34d6defc3215b4280fa"
  end

  def install
    ENV["GOPATH"] = buildpath

    mkdir_p buildpath/"src/github.com/joewalnes/"
    ln_sf buildpath, buildpath/"src/github.com/joewalnes/websocketd"
    Language::Go.stage_deps resources, buildpath/"src"

    system "go", "build", "-ldflags", "-X main.version=#{version}", "-o", bin/"websocketd",
                          "main.go", "config.go", "help.go", "version.go"
    man1.install "release/websocketd.man" => "websocketd.1"
  end

  test do
    pid = Process.fork { exec "#{bin}/websocketd", "--port=8080", "echo", "ok" }
    sleep 2

    begin
      assert_equal("404 page not found\n", shell_output("curl -s http://localhost:8080"))
    ensure
      Process.kill 9, pid
      Process.wait pid
    end
  end
end
