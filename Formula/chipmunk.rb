class Chipmunk < Formula
  desc "2D rigid body physics library written in C"
  homepage "https://chipmunk-physics.net/"
  url "https://chipmunk-physics.net/release/Chipmunk-7.x/Chipmunk-7.0.2.tgz"
  mirror "https://www.mirrorservice.org/sites/distfiles.macports.org/chipmunk/Chipmunk-7.0.2.tgz"
  sha256 "288c8465fcaa671bab890c0b24627816efa10da2c5eabbeb36feb0d6deb1ca5a"
  head "https://github.com/slembcke/Chipmunk2D.git"



  depends_on "cmake" => :build

  def install
    system "cmake", ".", "-DBUILD_DEMOS=OFF", *std_cmake_args
    system "make", "install"

    doc.install Dir["doc/*"]
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <chipmunk.h>

      int main(void){
        cpVect gravity = cpv(0, -100);
        cpSpace *space = cpSpaceNew();
        cpSpaceSetGravity(space, gravity);

        cpSpaceFree(space);
        return 0;
      }
    EOS
    system ENV.cc, "-I#{include}/chipmunk", "-L#{lib}", "-lchipmunk",
           testpath/"test.c", "-o", testpath/"test"
    system "./test"
  end
end
