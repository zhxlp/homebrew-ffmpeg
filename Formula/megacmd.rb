class Megacmd < Formula
  desc "Command-line client for mega.co.nz storage service"
  homepage "https://github.com/t3rm1n4l/megacmd"
  url "https://github.com/t3rm1n4l/megacmd/archive/0.015.tar.gz"
  sha256 "7c8e7ea1732351a044f4c6568629f3bb91ca40cd4937736dc53b074495b1a7f5"
  head "https://github.com/t3rm1n4l/megacmd.git"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/t3rm1n4l/megacmd").install buildpath.children
    cd "src/github.com/t3rm1n4l/megacmd" do
      system "go", "build", "-o", bin/"megacmd"
      prefix.install_metafiles
    end
  end

  test do
    system bin/"megacmd", "--version"
  end
end
