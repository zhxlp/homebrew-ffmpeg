class Scale2x < Formula
  desc "Real-time graphics effect"
  homepage "https://www.scale2x.it/"
  url "https://github.com/amadvance/scale2x/releases/download/v4.0/scale2x-4.0.tar.gz"
  sha256 "996f2673206c73fb57f0f5d0e094d3774f595f7e7e80fcca8cc045e8b4ba6d32"



  depends_on "libpng"

  def install
    system "./configure", "--prefix=#{prefix}", "CPPFLAGS=-I/usr/include/malloc/"
    system "make", "install"
  end
end
