class Curaengine < Formula
  desc "C++ 3D printing GCode generator"
  homepage "https://github.com/Ultimaker/CuraEngine"
  url "https://github.com/Ultimaker/CuraEngine/archive/15.04.6.tar.gz"
  sha256 "4f2e3c5e74001b39cf5894a1e3f436a7724be0ae9ee30cd02bd2e3fd676ca4b1"
  head "https://github.com/Ultimaker/CuraEngine.git"



  def install
    system "make", "VERSION=#{version}"
    bin.install "build/CuraEngine"
  end

  test do
    (testpath/"t.stl").write <<~EOS
      solid t
        facet normal 0 -1 0
         outer loop
          vertex 0.83404 0 0.694596
          vertex 0.36904 0 1.5
          vertex 1.78814e-006 0 0.75
         endloop
        endfacet
      endsolid Star
    EOS

    system "#{bin}/CuraEngine", "#{testpath}/t.stl"
  end
end
