class Xapian < Formula
  desc "C++ search engine library"
  homepage "https://xapian.org/"
  url "https://oligarchy.co.uk/xapian/1.4.7/xapian-core-1.4.7.tar.xz"
  mirror "https://fossies.org/linux/www/xapian-core-1.4.7.tar.xz"
  sha256 "13f08a0b649c7afa804fa0e85678d693fd6069dd394c9b9e7d41973d74a3b5d3"



  skip_clean :la

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"xapian-config", "--libs"
  end
end
