class GnomeThemesStandard < Formula
  desc "Default themes for the GNOME desktop environment"
  homepage "https://gitlab.gnome.org/GNOME/gnome-themes-extra"
  url "https://download.gnome.org/sources/gnome-themes-standard/3.22/gnome-themes-standard-3.22.3.tar.xz"
  sha256 "61dc87c52261cfd5b94d65e8ffd923ddeb5d3944562f84942eeeb197ab8ab56a"
  revision 1



  depends_on "gettext" => :build
  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "gtk+"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--disable-gtk3-engine"

    system "make", "install"
  end

  test do
    assert_predicate share/"icons/HighContrast/scalable/actions/document-open-recent.svg", :exist?
    assert_predicate lib/"gtk-2.0/2.10.0/engines/libadwaita.so", :exist?
  end
end
