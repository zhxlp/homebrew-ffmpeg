class Libantlr3c < Formula
  desc "ANTLRv3 parsing library for C"
  homepage "https://www.antlr3.org/"
  url "https://www.antlr3.org/download/C/libantlr3c-3.4.tar.gz"
  sha256 "ca914a97f1a2d2f2c8e1fca12d3df65310ff0286d35c48b7ae5f11dcc8b2eb52"
  revision 1



  def install
    args = ["--disable-dependency-tracking",
            "--disable-antlrdebug",
            "--prefix=#{prefix}",
            "--enable-64bit"]
    system "./configure", *args

    inreplace "Makefile" do |s|
      cflags = s.get_make_var "CFLAGS"
      cflags = cflags << " -fexceptions"
      s.change_make_var! "CFLAGS", cflags
    end

    system "make", "install"
  end

  test do
    (testpath/"hello.c").write <<~EOS
      #include <antlr3.h>
      int main() {
        if (0) {
          antlr3GenericSetupStream(NULL);
        }
        return 0;
      }
    EOS
    system ENV.cc, "hello.c", "-L#{lib}", "-lantlr3c", "-o", "hello", "-O0"
    system testpath/"hello"
  end
end
