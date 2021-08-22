class Libnotify < Formula
  desc "Library that sends desktop notifications to a notification daemon"
  homepage "https://developer.gnome.org/libnotify"
  url "https://download.gnome.org/sources/libnotify/0.7/libnotify-0.7.7.tar.xz"
  sha256 "9cb4ce315b2655860c524d46b56010874214ec27e854086c1a1d0260137efc04"
  revision 1



  depends_on "gobject-introspection" => :build
  depends_on "pkg-config" => :build
  depends_on "gdk-pixbuf"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--disable-tests",
                          "--enable-introspection"
    system "make", "install"
  end
end
