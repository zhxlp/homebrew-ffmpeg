class LiquidDsp < Formula
  desc "Digital signal processing library for software-defined radios"
  homepage "http://liquidsdr.org/"
  url "https://github.com/jgaeddert/liquid-dsp/archive/v1.3.1.tar.gz"
  sha256 "e3f66ce72a3b5d74eea5ccffb049c62c422c91b0ab92d6dbbef21af3c3bfec73"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "fftw"

  def install
    system "./bootstrap.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <liquid/liquid.h>
      int main() {
        if (!liquid_is_prime(3))
          return 1;
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-o", "test", "-L#{lib}", "-lliquid"
    system "./test"
  end
end
