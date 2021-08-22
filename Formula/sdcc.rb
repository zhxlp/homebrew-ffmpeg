class Sdcc < Formula
  desc "ANSI C compiler for Intel 8051, Maxim 80DS390, and Zilog Z80"
  homepage "https://sdcc.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/sdcc/sdcc/3.8.0/sdcc-src-3.8.0.tar.bz2"
  sha256 "b331668deb7bd832efd112052e5b0ed2313db641a922bd39280ba6d47adbbb21"
  head "https://svn.code.sf.net/p/sdcc/code/trunk/sdcc"



  depends_on "boost"
  depends_on "gputils"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "all"
    system "make", "install"
    rm Dir["#{bin}/*.el"]
  end

  test do
    system "#{bin}/sdcc", "-v"
  end
end
