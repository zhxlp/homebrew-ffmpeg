class Libwpg < Formula
  desc "Library for reading and parsing Word Perfect Graphics format"
  homepage "https://libwpg.sourceforge.io/"
  url "https://dev-www.libreoffice.org/src/libwpg-0.3.2.tar.xz"
  sha256 "57faf1ab97d63d57383ac5d7875e992a3d190436732f4083310c0471e72f8c33"



  depends_on "pkg-config" => :build
  depends_on "librevenge"
  depends_on "libwpd"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <libwpg/libwpg.h>
      int main() {
        return libwpg::WPG_AUTODETECT;
      }
    EOS
    system ENV.cc, "test.cpp",
                   "-I#{Formula["librevenge"].opt_include}/librevenge-0.0",
                   "-I#{include}/libwpg-0.3",
                   "-L#{Formula["librevenge"].opt_lib}",
                   "-L#{lib}",
                   "-lwpg-0.3", "-lrevenge-0.0",
                   "-o", "test"
    system "./test"
  end
end
