class ChinadnsC < Formula
  desc "Port of ChinaDNS to C: fix irregularities with DNS in China"
  homepage "https://github.com/shadowsocks/ChinaDNS"
  url "https://github.com/shadowsocks/ChinaDNS/releases/download/1.3.2/chinadns-1.3.2.tar.gz"
  sha256 "abfd433e98ac0f31b8a4bd725d369795181b0b6e8d1b29142f1bb3b73bbc7230"



  head do
    url "https://github.com/shadowsocks/ChinaDNS.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/chinadns", "-h"
  end
end
