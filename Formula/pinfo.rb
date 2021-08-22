class Pinfo < Formula
  desc "User-friendly, console-based viewer for Info documents"
  homepage "https://packages.debian.org/sid/pinfo"
  url "https://mirrorservice.org/sites/distfiles.macports.org/pinfo/pinfo-0.6.10.tar.bz2"
  sha256 "122180a0c23d11bc9eb569a4de3ff97d3052af96e32466fa62f2daf46ff61c5d"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "gettext"

  def install
    system "autoreconf", "--force", "--install"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/pinfo", "-h"
  end
end
