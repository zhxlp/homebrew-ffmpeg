class Devd < Formula
  desc "Local webserver for developers"
  homepage "https://github.com/cortesi/devd"
  url "https://github.com/cortesi/devd/archive/v0.9.tar.gz"
  sha256 "5aee062c49ffba1e596713c0c32d88340360744f57619f95809d01c59bff071f"
  head "https://github.com/cortesi/devd.git"



  depends_on "go" => :build

  def install
    ENV["GOOS"] = "darwin"
    ENV["GOARCH"] = "amd64"
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/cortesi/devd").install buildpath.children
    cd "src/github.com/cortesi/devd" do
      system "go", "build", "-o", bin/"devd", ".../cmd/devd"
      prefix.install_metafiles
    end
  end

  test do
    begin
      io = IO.popen("#{bin}/devd -s #{testpath}")
      sleep 2
    ensure
      Process.kill("SIGINT", io.pid)
      Process.wait(io.pid)
    end

    assert_match "Listening on https://devd.io", io.read
  end
end
