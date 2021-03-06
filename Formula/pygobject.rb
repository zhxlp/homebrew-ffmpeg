class Pygobject < Formula
  desc "GLib/GObject/GIO Python bindings for Python 2"
  homepage "https://wiki.gnome.org/Projects/PyGObject"
  url "https://download.gnome.org/sources/pygobject/2.28/pygobject-2.28.7.tar.xz"
  sha256 "bb9d25a3442ca7511385a7c01b057492095c263784ef31231ffe589d83a96a5a"
  revision 1



  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "python@2"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-introspection"
    system "make", "install"
    (lib/"python2.7/site-packages/pygtk.pth").append_lines <<~EOS
      #{HOMEBREW_PREFIX}/lib/python2.7/site-packages/gtk-2.0
    EOS
  end

  test do
    system Formula["python@2"].opt_bin/"python2.7", "-c", "import dsextras"
  end
end
