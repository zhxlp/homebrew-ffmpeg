class Jerasure < Formula
  desc "Library in C that supports erasure coding in storage applications"
  homepage "http://jerasure.org/"
  url "https://bitbucket.org/tsg-/jerasure/get/v2.0.0.tar.bz2"
  sha256 "f736646c1844c4e50dfe41ebd63c7d7b30c6e66a4aa7d3beea244871b0e43b9d"
  revision 1



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "gf-complete"

  def install
    system "autoreconf", "--force", "--install"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"jerasure_01", "2", "5", "3"
  end
end
