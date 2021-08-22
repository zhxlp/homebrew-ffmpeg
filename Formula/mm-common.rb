class MmCommon < Formula
  desc "Build utilities for C++ interfaces of GTK+ and GNOME packages"
  homepage "https://www.gtkmm.org/"
  url "https://download.gnome.org/sources/mm-common/0.9/mm-common-0.9.12.tar.xz"
  sha256 "ceffdcce1e5b52742884c233ec604bf6fded12eea9da077ce7a62c02c87e7c0b"



  def install
    system "./configure", "--disable-silent-rules", "--prefix=#{prefix}"
    system "make", "install"
  end
end
