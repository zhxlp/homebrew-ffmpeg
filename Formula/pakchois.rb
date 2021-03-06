class Pakchois < Formula
  desc "PKCS #11 wrapper library"
  homepage "https://web.archive.org/web/www.manyfish.co.uk/pakchois/"
  url "https://web.archive.org/web/20161220165909/www.manyfish.co.uk/pakchois/pakchois-0.4.tar.gz"
  sha256 "d73dc5f235fe98e4d1e8c904f40df1cf8af93204769b97dbb7ef7a4b5b958b9a"



  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
