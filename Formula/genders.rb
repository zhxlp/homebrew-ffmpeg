class Genders < Formula
  desc "Static cluster configuration database for cluster management"
  homepage "https://computing.llnl.gov/linux/genders.html"
  url "https://downloads.sourceforge.net/project/genders/genders/1.22-1/genders-1.22.tar.gz"
  sha256 "0ff292825a29201106239c4d47d9ce4c6bda3f51c78c0463eb2634ecc337b774"



  def install
    system "./configure", "--prefix=#{prefix}", "--with-java-extensions=no"
    system "make", "install"
  end
end
