class Shapelib < Formula
  desc "Library for reading and writing ArcView Shapefiles"
  homepage "http://shapelib.maptools.org/"
  url "https://download.osgeo.org/shapelib/shapelib-1.4.1.tar.gz"
  sha256 "a4c94817365761a3a4c21bb3ca1c680a6bdfd3edd61df9fdd291d3e7645923b3"



  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    assert_match "shp_file", shell_output("#{bin}/shptreedump", 1)
  end
end
