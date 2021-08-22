class Libodfgen < Formula
  desc "ODF export library for projects using librevenge"
  homepage "https://sourceforge.net/p/libwpd/wiki/libodfgen/"
  url "https://dev-www.libreoffice.org/src/libodfgen-0.1.6.tar.bz2"
  mirror "https://downloads.sourceforge.net/project/libwpd/libodfgen/libodfgen-0.1.6/libodfgen-0.1.6.tar.bz2"
  sha256 "2c7b21892f84a4c67546f84611eccdad6259875c971e98ddb027da66ea0ac9c2"



  depends_on "boost" => :build
  depends_on "libetonyek" => :build
  depends_on "libwpg" => :build
  depends_on "pkg-config" => :build
  depends_on "librevenge"
  depends_on "libwpd"

  def install
    system "./configure", "--without-docs",
                          "--disable-dependency-tracking",
                          "--enable-static=no",
                          "--with-sharedptr=boost",
                          "--disable-werror",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <libodfgen/OdfDocumentHandler.hxx>
      int main() {
        return ODF_FLAT_XML;
      }
    EOS
    system ENV.cxx, "test.cpp", "-o", "test",
      "-lrevenge-0.0",
      "-I#{Formula["librevenge"].include}/librevenge-0.0",
      "-L#{Formula["librevenge"].lib}",
      "-lodfgen-0.1",
      "-I#{include}/libodfgen-0.1",
      "-L#{lib}"
    system "./test"
  end
end
