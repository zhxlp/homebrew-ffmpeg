class Tcping < Formula
  desc "TCP connect to the given IP/port combo"
  homepage "https://web.archive.org/web/20171102193822/linuxco.de/tcping/tcping.html"
  url "https://mirrors.kernel.org/gentoo/distfiles/tcping-1.3.5.tar.gz"
  sha256 "1ad52e904094d12b225ac4a0bc75297555e931c11a1501445faa548ff5ecdbd0"



  def install
    system "make"
    bin.install "tcping"
  end

  test do
    system "#{bin}/tcping", "www.google.com", "80"
  end
end
