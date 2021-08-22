class Concurrencykit < Formula
  desc "Aid design and implementation of concurrent systems"
  homepage "http://concurrencykit.org"
  url "http://concurrencykit.org/releases/ck-0.6.0.tar.gz"
  mirror "https://github.com/concurrencykit/ck/archive/0.6.0.tar.gz"
  sha256 "d7e27dd0a679e45632951e672f8288228f32310dfed2d5855e9573a9cf0d62df"
  head "https://github.com/concurrencykit/ck.git"



  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <ck_spinlock.h>
      int main()
      {
          return 0;
      }
    EOS
    system ENV.cc, "-I#{include}", "-L#{lib}", "-lck",
           testpath/"test.c", "-o", testpath/"test"
    system "./test"
  end
end
