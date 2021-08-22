class Libnxml < Formula
  desc "C library for parsing, writing, and creating XML files"
  homepage "https://www.autistici.org/bakunin/libnxml/"
  url "https://www.autistici.org/bakunin/libnxml/libnxml-0.18.3.tar.gz"
  sha256 "0f9460e3ba16b347001caf6843f0050f5482e36ebcb307f709259fd6575aa547"



  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
