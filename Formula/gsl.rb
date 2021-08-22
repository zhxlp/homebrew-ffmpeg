class Gsl < Formula
  desc "Numerical library for C and C++"
  homepage "https://www.gnu.org/software/gsl/"
  url "https://ftp.gnu.org/gnu/gsl/gsl-2.5.tar.gz"
  mirror "https://ftpmirror.gnu.org/gsl/gsl-2.5.tar.gz"
  sha256 "0460ad7c2542caaddc6729762952d345374784100223995eb14d614861f2258d"



  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make" # A GNU tool which doesn't support just make install! Shameful!
    system "make", "install"
  end

  test do
    system bin/"gsl-randist", "0", "20", "cauchy", "30"
  end
end
