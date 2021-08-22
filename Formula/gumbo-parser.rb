class GumboParser < Formula
  desc "C99 library for parsing HTML5"
  homepage "https://github.com/google/gumbo-parser"
  url "https://github.com/google/gumbo-parser/archive/v0.10.1.tar.gz"
  sha256 "28463053d44a5dfbc4b77bcf49c8cee119338ffa636cc17fc3378421d714efad"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "./autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include "gumbo.h"

      int main() {
        GumboOutput* output = gumbo_parse("<h1>Hello, World!</h1>");
        gumbo_destroy_output(&kGumboDefaultOptions, output);
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-L#{lib}", "-lgumbo", "-o", "test"
    system "./test"
  end
end
