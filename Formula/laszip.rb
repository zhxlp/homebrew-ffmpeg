class Laszip < Formula
  desc "Lossless LiDAR compression"
  homepage "https://laszip.org/"
  url "https://github.com/LASzip/LASzip/releases/download/3.2.9/laszip-src-3.2.9.tar.gz"
  sha256 "a1cc9ea5adfcad43b9c8afbaff20bcd573a85c90dd83d5c8e17e4ff8d8d4548e"
  head "https://github.com/LASzip/LASzip.git"



  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    pkgshare.install "example"
  end

  test do
    system ENV.cxx, pkgshare/"example/laszipdllexample.cpp", "-L#{lib}",
                    "-llaszip", "-llaszip_api", "-Wno-format", "-o", "test"
    assert_match "LASzip DLL", shell_output("./test -h 2>&1", 1)
  end
end
