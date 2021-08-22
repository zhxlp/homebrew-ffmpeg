class Ptex < Formula
  desc "Texture mapping system"
  homepage "http://ptex.us"
  url "https://github.com/wdas/ptex/archive/v2.1.33.tar.gz"
  sha256 "7c437de43fbfd45b8355f528b0276650e6f6a82357591a8540ca4b7e2012a327"



  depends_on "cmake" => :build

  def install
    system "make", "prefix=#{prefix}"
    system "make", "test"
    system "make", "install"
  end
end
