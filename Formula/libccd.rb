class Libccd < Formula
  desc "Collision detection between two convex shapes"
  homepage "http://libccd.danfis.cz/"
  url "https://github.com/danfis/libccd/archive/v2.1.tar.gz"
  sha256 "542b6c47f522d581fbf39e51df32c7d1256ac0c626e7c2b41f1040d4b9d50d1e"



  depends_on "cmake" => :build

  def install
    system "cmake", ".", "-DCCD_DOUBLE=ON", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <assert.h>
      #include <ccd/config.h>
      #include <ccd/vec3.h>
      int main() {
      #ifndef CCD_DOUBLE
        assert(false);
      #endif
        ccdVec3PointSegmentDist2(
          ccd_vec3_origin, ccd_vec3_origin,
          ccd_vec3_origin, NULL);
        return 0;
      }
    EOS
    system ENV.cc, "-o", "test", "test.c", "-L#{lib}", "-lccd"
    system "./test"
  end
end
