class Libsoup < Formula
  desc "HTTP client/server library for GNOME"
  homepage "https://wiki.gnome.org/Projects/libsoup"
  url "https://download.gnome.org/sources/libsoup/2.64/libsoup-2.64.2.tar.xz"
  sha256 "75ddc194a5b1d6f25033bb9d355f04bfe5c03e0e1c71ed0774104457b3a786c6"



  depends_on "gobject-introspection" => :build
  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "python" => :build
  depends_on "glib-networking"
  depends_on "gnutls"
  depends_on "libpsl"
  depends_on "vala"

  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --disable-tls-check
      --enable-introspection=yes
    ]

    # ensures that the vala files remain within the keg
    inreplace "libsoup/Makefile.in",
              "VAPIDIR = @VAPIDIR@",
              "VAPIDIR = @datadir@/vala/vapi"

    system "./configure", *args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <libsoup/soup.h>

      int main(int argc, char *argv[]) {
        guint version = soup_get_major_version();
        return 0;
      }
    EOS
    ENV.libxml2
    gettext = Formula["gettext"]
    glib = Formula["glib"]
    flags = %W[
      -I#{gettext.opt_include}
      -I#{glib.opt_include}/glib-2.0
      -I#{glib.opt_lib}/glib-2.0/include
      -I#{include}/libsoup-2.4
      -D_REENTRANT
      -L#{gettext.opt_lib}
      -L#{glib.opt_lib}
      -L#{lib}
      -lgio-2.0
      -lglib-2.0
      -lgobject-2.0
      -lsoup-2.4
    ]
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
  end
end
