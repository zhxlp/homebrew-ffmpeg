class Jbig2enc < Formula
  desc "JBIG2 encoder (for monochrome documents)"
  homepage "https://github.com/agl/jbig2enc"
  url "https://github.com/agl/jbig2enc/archive/0.29.tar.gz"
  sha256 "bfcf0d0448ee36046af6c776c7271cd5a644855723f0a832d1c0db4de3c21280"
  head "https://github.com/agl/jbig2enc.git"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "leptonica"

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end
end
