class Pygtkglext < Formula
  desc "Python bindings to OpenGL GTK+ extension"
  homepage "https://projects.gnome.org/gtkglext/download.html#pygtkglext"
  url "https://download.gnome.org/sources/pygtkglext/1.1/pygtkglext-1.1.0.tar.gz"
  sha256 "9712c04c60bf6ee7d05e0c6a6672040095c2ea803a1546af6dfde562dc0178a3"
  revision 3



  depends_on "pkg-config" => :build
  depends_on "gtkglext"
  depends_on "pygobject"
  depends_on "pygtk"

  def install
    inreplace "gtk/gdkgl/gdkglext.override", "#include <GL/gl.h>", "#include <gl.h>"

    ENV["PYGTK_CODEGEN"] = "#{Formula["pygobject"].opt_bin}/pygobject-codegen-2.0"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    ENV.append_path "PYTHONPATH", Formula["pygtk"].opt_lib/"python2.7/site-packages/gtk-2.0"
    system "python2.7", "-c", "import pygtk", "pygtk.require('2.0')", "import gtk.gtkgl"
  end
end
