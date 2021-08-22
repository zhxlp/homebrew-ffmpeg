class Termbox < Formula
  desc "Library for writing text-based user interfaces"
  homepage "https://code.google.com/p/termbox/"
  url "https://github.com/nsf/termbox/archive/v1.1.2.tar.gz"
  sha256 "61c9940b42b3ac44bf0cba67eacba75e3c02088b8c695149528c77def04d69b1"
  head "https://github.com/nsf/termbox.git"



  def install
    system "./waf", "configure", "--prefix=#{prefix}"
    system "./waf"
    system "./waf", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <termbox.h>
      int main() {
        // we can't test other functions because the CI test runs in a
        // non-interactive shell
        tb_set_clear_attributes(42, 42);
      }
    EOS

    system ENV.cc, "test.c", "-L#{lib}", "-ltermbox", "-o", "test"
    system "./test"
  end
end
