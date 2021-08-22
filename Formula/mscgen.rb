class Mscgen < Formula
  desc "Parses Message Sequence Chart descriptions and produces images"
  homepage "http://www.mcternan.me.uk/mscgen/"
  url "http://www.mcternan.me.uk/mscgen/software/mscgen-src-0.20.tar.gz"
  sha256 "3c3481ae0599e1c2d30b7ed54ab45249127533ab2f20e768a0ae58d8551ddc23"
  revision 3



  depends_on "pkg-config" => :build
  depends_on "freetype"
  depends_on "gd"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--with-freetype",
                          "--disable-dependency-tracking"
    system "make", "install"
  end
end
