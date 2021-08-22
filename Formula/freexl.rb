class Freexl < Formula
  desc "Library to extract data from Excel .xls files"
  homepage "https://www.gaia-gis.it/fossil/freexl/index"
  url "https://www.gaia-gis.it/gaia-sins/freexl-sources/freexl-1.0.5.tar.gz"
  sha256 "3dc9b150d218b0e280a3d6a41d93c1e45f4d7155829d75f1e5bf3e0b0de6750d"
  revision 1



  depends_on "doxygen" => :build

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}",
                          "--disable-silent-rules"

    system "make", "check"
    system "make", "install"

    system "doxygen"
    doc.install "html"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include "freexl.h"

      int main()
      {
          printf(freexl_version());
          return 0;
      }
    EOS
    system ENV.cc, "-L#{lib}", "-lfreexl", "test.c", "-o", "test"
    assert_equal version.to_s, shell_output("./test")
  end
end
