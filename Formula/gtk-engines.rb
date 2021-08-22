class GtkEngines < Formula
  desc "Themes for GTK+"
  homepage "https://github.com/GNOME/gtk-engines"
  url "https://download.gnome.org/sources/gtk-engines/2.20/gtk-engines-2.20.2.tar.bz2"
  sha256 "15b680abca6c773ecb85253521fa100dd3b8549befeecc7595b10209d62d66b5"
  revision 2



  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "cairo"
  depends_on "gettext"
  depends_on "gtk+"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  def caveats; <<~EOS
    You will need to set:
      GTK_PATH=#{HOMEBREW_PREFIX}/lib/gtk-2.0
    as by default GTK looks for modules in Cellar.
  EOS
  end

  test do
    assert_predicate pkgshare/"clearlooks.xml", :exist?
    assert_predicate lib/"gtk-2.0/2.10.0/engines/libhcengine.so", :exist?
    assert_predicate share/"themes/Industrial/gtk-2.0/gtkrc", :exist?
  end
end
