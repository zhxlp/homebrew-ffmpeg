class GupnpAv < Formula
  desc "Library to help implement UPnP A/V profiles"
  homepage "https://wiki.gnome.org/GUPnP/"
  url "https://download.gnome.org/sources/gupnp-av/0.12/gupnp-av-0.12.11.tar.xz"
  sha256 "689dcf1492ab8991daea291365a32548a77d1a2294d85b33622b55cca9ce6fdc"



  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "gupnp"

  def install
    ENV["ax_cv_check_cflags__Wl___no_as_needed"] = "no"

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
