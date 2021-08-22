class Less < Formula
  desc "Pager program similar to more"
  homepage "http://www.greenwoodsoftware.com/less/index.html"
  url "https://ftp.gnu.org/gnu/less/less-530.tar.gz"
  mirror "https://ftpmirror.gnu.org/less/less-530.tar.gz"
  sha256 "503f91ab0af4846f34f0444ab71c4b286123f0044a4964f1ae781486c617f2e2"
  revision 1



  depends_on "pcre"

  def install
    system "./configure", "--prefix=#{prefix}", "--with-regex=pcre"
    system "make", "install"
  end

  test do
    system "#{bin}/lesskey", "-V"
  end
end
