class Rush < Formula
  desc "GNU's Restricted User SHell"
  homepage "https://www.gnu.org/software/rush/"
  url "https://ftp.gnu.org/gnu/rush/rush-1.8.tar.gz"
  mirror "https://ftpmirror.gnu.org/rush/rush-1.8.tar.gz"
  sha256 "7f321e5556435b12638982c8d94c587982122f28c220f8bc679d7817035aadef"



  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{sbin}/rush", "-h"
  end
end
