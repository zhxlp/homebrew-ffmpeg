class Libmatroska < Formula
  desc "Extensible, open standard container format for audio/video"
  homepage "https://www.matroska.org/"
  url "https://dl.matroska.org/downloads/libmatroska/libmatroska-1.4.9.tar.xz"
  sha256 "38a61dd5d87c070928b5deb3922b63b2b83c09e2e4a10f9393eecb6afa9795c8"
  head "https://github.com/Matroska-Org/libmatroska.git"



  depends_on "cmake" => :build
  depends_on "libebml"

  def install
    mkdir "build" do
      system "cmake", "..", "-DBUILD_SHARED_LIBS=YES", *std_cmake_args
      system "make", "install"
    end
  end
end
