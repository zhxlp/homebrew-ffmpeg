class Libtecla < Formula
  desc "Command-line editing facilities similar to the tcsh shell"
  homepage "http://www.astro.caltech.edu/~mcs/tecla/index.html"
  url "http://www.astro.caltech.edu/~mcs/tecla/libtecla-1.6.3.tar.gz"
  sha256 "f2757cc55040859fcf8f59a0b7b26e0184a22bece44ed9568a4534a478c1ee1a"



  def install
    ENV.deparallelize
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <locale.h>
      #include <libtecla.h>

      int main(int argc, char *argv[]) {
        GetLine *gl;
        setlocale(LC_CTYPE, "");
        gl = new_GetLine(1024, 2048);
        if (!gl) return 1;
        return 0;
      }
    EOS

    system ENV.cc, "test.c", "-L#{lib}", "-ltecla", "-o", "test"
    system "./test"
  end
end
