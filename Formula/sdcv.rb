class Sdcv < Formula
  desc "StarDict Console Version"
  homepage "https://dushistov.github.io/sdcv/"
  url "https://github.com/Dushistov/sdcv/archive/v0.5.2.tar.gz"
  sha256 "ec08dc084a0748d5a89df01a20bbf294f09b0366295cd418000f15d2e043c4f7"
  revision 1
  version_scheme 1
  head "https://github.com/Dushistov/sdcv.git"



  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "glib"
  depends_on "readline"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "lang"
      system "make", "install"
    end
  end

  test do
    system bin/"sdcv", "-h"
  end
end
