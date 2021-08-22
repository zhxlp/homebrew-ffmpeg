class T1utils < Formula
  desc "Command-line tools for dealing with Type 1 fonts"
  homepage "https://www.lcdf.org/type/"
  url "https://www.lcdf.org/type/t1utils-1.41.tar.gz"
  sha256 "fc5edd7e829902b3b685886382fed690d533681c0ab218a387c9e47606623427"



  head do
    url "https://github.com/kohler/t1utils.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  def install
    system "./bootstrap.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/t1mac", "--version"
  end
end
