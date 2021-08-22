class Libvidstab < Formula
  desc "Transcode video stabilization plugin"
  homepage "http://public.hronopik.de/vid.stab/"
  url "https://github.com/georgmartius/vid.stab/archive/v1.1.0.tar.gz"
  sha256 "14d2a053e56edad4f397be0cb3ef8eb1ec3150404ce99a426c4eb641861dc0bb"



  depends_on "cmake" => :build

  def install
    system "cmake", ".", "-DUSE_OMP=OFF", *std_cmake_args
    system "make", "install"
  end
end
