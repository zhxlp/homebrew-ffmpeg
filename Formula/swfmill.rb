class Swfmill < Formula
  desc "xml2swf and swf2xml processor"
  homepage "https://swfmill.org"
  url "https://www.swfmill.org/releases/swfmill-0.3.6.tar.gz"
  sha256 "db24f63963957faec02bb14b8b61cdaf7096774f8cfdeb9d3573e2e19231548e"



  depends_on "pkg-config" => :build
  depends_on "freetype"
  depends_on "libpng"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end
end
