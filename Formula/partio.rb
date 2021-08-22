class Partio < Formula
  desc "Particle library for 3D graphics"
  homepage "https://github.com/wdas/partio"
  url "https://github.com/wdas/partio/archive/v1.1.0.tar.gz"
  sha256 "133f386f076bd6958292646b6ba0e3db6d1e37bde3b8a6d1bc4b7809d693999d"



  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "swig" => :build

  # These fixes are upstream and can be removed in the next released version.
  patch do
    url "https://github.com/wdas/partio/commit/5b80b00ddedaef9ffed19ea4e6773ed1dc27394e.diff?full_index=1"
    sha256 "b14b5526d5b61a3dfec7ddd07b54d5a678170b15b3f83687ab1b4151ae0cd5f3"
  end

  patch do
    url "https://github.com/wdas/partio/commit/bdce60e316b699fb4fd813c6cad9d369205657c8.diff?full_index=1"
    sha256 "58dc0b77155b80301595c0b6a439e852f41779a31348f1716f2c9714273c638b"
  end

  patch do
    url "https://github.com/wdas/partio/commit/e557c212b0e8e0c4830e7991541686d568853afd.diff?full_index=1"
    sha256 "b20a25142316cf93c0cc1188508c39a01275cf784d628e9768d5ee1471adbee2"
  end

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "doc"
      system "make", "install"
    end
  end
end
