class Cliclick < Formula
  desc "Tool for emulating mouse and keyboard events"
  homepage "https://www.bluem.net/jump/cliclick/"
  url "https://github.com/BlueM/cliclick/archive/4.0.1.tar.gz"
  sha256 "78f9584524b2cb4710a964f4d8e23667479f1dab37240d1ffbc8dfa9841ff1c2"
  head "https://github.com/BlueM/cliclick.git"



  def install
    system "make"
    bin.install "cliclick"
  end

  test do
    system bin/"cliclick", "p:OK"
  end
end
