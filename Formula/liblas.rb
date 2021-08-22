class Liblas < Formula
  desc "C/C++ library for reading and writing the LAS LiDAR format"
  homepage "https://liblas.org/"
  url "https://download.osgeo.org/liblas/libLAS-1.8.1.tar.bz2"
  sha256 "9adb4a98c63b461ed2bc82e214ae522cbd809cff578f28511122efe6c7ea4e76"
  revision 1
  head "https://github.com/libLAS/libLAS.git"



  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "gdal"
  depends_on "libgeotiff"

  # Fix build for Xcode 9 with upstream commit
  # Remove in next version
  patch do
    url "https://github.com/libLAS/libLAS/commit/49606470.patch?full_index=1"
    sha256 "5590aef61a58768160051997ae9753c2ae6fc5b7da8549707dfd9a682ce439c8"
  end

  # Fix compilation against GDAL 2.3
  # Remove in next version
  patch do
    url "https://github.com/libLAS/libLAS/commit/ec10e274.diff?full_index=1"
    sha256 "3f5cc283d3e908d991b05b4dcf5cc0440824441ec270396e11738f96a0a23a9f"
  end

  def install
    ENV.cxx11

    mkdir "macbuild" do
      # CMake finds boost, but variables like this were set in the last
      # version of this formula. Now using the variables listed here:
      #   https://liblas.org/compilation.html
      ENV["Boost_INCLUDE_DIR"] = "#{HOMEBREW_PREFIX}/include"
      ENV["Boost_LIBRARY_DIRS"] = "#{HOMEBREW_PREFIX}/lib"

      system "cmake", "..", *std_cmake_args,
                            "-DWITH_GDAL=ON",
                            "-DWITH_GEOTIFF=ON"
      system "make"
      system "make", "test"
      system "make", "install"
    end
  end

  test do
    system bin/"liblas-config", "--version"
  end
end
