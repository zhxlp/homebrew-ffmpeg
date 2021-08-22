class Twemcache < Formula
  desc "Twitter fork of memcached"
  homepage "https://github.com/twitter/twemcache"
  url "https://github.com/twitter/twemcache/archive/v2.6.3.tar.gz"
  sha256 "ab05927f7d930b7935790450172187afedca742ee7963d5db1e62164e7f4c92b"
  head "https://github.com/twitter/twemcache.git"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libevent"

  def install
    system "autoreconf", "-fvi"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"twemcache", "--help"
  end
end
