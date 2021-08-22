class Gti < Formula
  desc "ASCII-art displaying typo-corrector for commands"
  homepage "http://r-wos.org/hacks/gti"
  url "https://github.com/rwos/gti/archive/v1.6.1.tar.gz"
  sha256 "6dd5511b92b64df115b358c064e7701b350b343f30711232a8d74c6274c962a5"
  head "https://github.com/rwos/gti.git"



  def install
    system "make", "CC=#{ENV.cc}", "CFLAGS=#{ENV.cflags}"
    bin.install "gti"
    man6.install "gti.6"
  end

  test do
    system "#{bin}/gti", "init"
  end
end
