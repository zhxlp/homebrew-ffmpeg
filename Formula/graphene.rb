class Graphene < Formula
  desc "Thin layer of graphic data types"
  homepage "https://ebassi.github.io/graphene/"
  url "https://download.gnome.org/sources/graphene/1.8/graphene-1.8.2.tar.xz"
  sha256 "b3fcf20996e57b1f4df3941caac10f143bb29890a42f7a65407cd19271fc89f7"



  depends_on "gobject-introspection" => :build
  depends_on "meson-internal" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "python" => :build
  depends_on "glib"

  patch :DATA

  def install
    ENV.refurbish_args

    mkdir "build" do
      system "meson", "--prefix=#{prefix}", ".."
      system "ninja"
      system "ninja", "install"
    end
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <graphene-gobject.h>

      int main(int argc, char *argv[]) {
      GType type = graphene_point_get_type();
        return 0;
      }
    EOS
    gettext = Formula["gettext"]
    glib = Formula["glib"]
    flags = %W[
      -I#{gettext.opt_include}
      -I#{glib.opt_include}/glib-2.0
      -I#{glib.opt_lib}/glib-2.0/include
      -I#{include}/graphene-1.0
      -I#{lib}/graphene-1.0/include
      -L#{lib}
      -lgraphene-1.0
    ]
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
  end
end

__END__
diff --git a/meson.build b/meson.build
index 0736994..5932028 100644
--- a/meson.build
+++ b/meson.build
@@ -112,11 +112,6 @@ if host_system == 'linux' and cc.get_id() == 'gcc'
   common_ldflags = [ '-Wl,-Bsymbolic-functions', '-Wl,-z,relro', '-Wl,-z,now', ]
 endif

-# Maintain compatibility with Autotools on macOS
-if host_system == 'darwin'
-  common_ldflags += [ '-compatibility_version 1', '-current_version 1.0', ]
-endif
-
 # Required dependencies
 mathlib = cc.find_library('m', required: false)
 threadlib = dependency('threads')
