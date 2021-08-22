class ArpSk < Formula
  desc "ARP traffic generation tool"
  homepage "https://web.archive.org/web/20180223202629/sid.rstack.org/arp-sk/"
  url "https://web.archive.org/web/20180223202629/sid.rstack.org/arp-sk/files/arp-sk-0.0.16.tgz"
  mirror "https://pkg.freebsd.org/ports-distfiles/arp-sk-0.0.16.tgz"
  sha256 "6e1c98ff5396dd2d1c95a0d8f08f85e51cf05b1ed85ea7b5bcf73c4ca5d301dd"



  depends_on "libnet"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--with-libnet=#{Formula["libnet"].opt_prefix}"
    system "make", "install"
  end

  test do
    assert_match "arp-sk version #{version}", shell_output("#{sbin}/arp-sk -V")
  end
end
