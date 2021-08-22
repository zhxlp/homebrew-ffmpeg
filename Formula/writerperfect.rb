class Writerperfect < Formula
  desc "Library for importing WordPerfect documents"
  homepage "https://sourceforge.net/p/libwpd/wiki/writerperfect/"
  url "https://downloads.sourceforge.net/project/libwpd/writerperfect/writerperfect-0.9.6/writerperfect-0.9.6.tar.xz"
  sha256 "1fe162145013a9786b201cb69724b2d55ff2bf2354c3cd188fd4466e7fc324e6"



  depends_on "boost" => :build
  depends_on "pkg-config" => :build
  depends_on "libodfgen"
  depends_on "libwpd"
  depends_on "libwpg"
  depends_on "libwps"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
