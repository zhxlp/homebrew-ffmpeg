class Mlogger < Formula
  desc "Log to syslog from the command-line"
  homepage "https://github.com/nbrownus/mlogger"
  url "https://github.com/nbrownus/mlogger/archive/v1.2.0.tar.gz"
  sha256 "141bb9af13a8f0e865c8509ac810c10be4e21f14db5256ef5c7a6731b490bf32"



  def install
    system "make"
    bin.install "mlogger"
  end

  test do
    system "#{bin}/mlogger", "-i", "-d", "test"
  end
end
