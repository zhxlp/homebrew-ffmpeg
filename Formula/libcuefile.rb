class Libcuefile < Formula
  desc "Library to work with CUE files"
  homepage "https://www.musepack.net/"
  url "https://files.musepack.net/source/libcuefile_r475.tar.gz"
  version "r475"
  sha256 "b681ca6772b3f64010d24de57361faecf426ee6182f5969fcf29b3f649133fe7"



  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    include.install "include/cuetools/"
  end
end
