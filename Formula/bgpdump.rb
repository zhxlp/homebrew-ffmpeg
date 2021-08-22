class Bgpdump < Formula
  desc "C library for analyzing MRT/Zebra/Quagga dump files"
  homepage "https://bitbucket.org/ripencc/bgpdump/wiki/Home"
  url "https://bitbucket.org/ripencc/bgpdump/get/1.6.0.tar.gz"
  sha256 "0a9f97ac79b6f093a54e39a6b952bd8fec7ca4d7352abf2509c464fdbdb2a79b"



  depends_on "autoconf" => :build

  def install
    system "./bootstrap.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    system "#{bin}/bgpdump", "-T"
  end
end
