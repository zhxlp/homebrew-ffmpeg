class Hackrf < Formula
  desc "Low cost software radio platform"
  homepage "https://github.com/mossmann/hackrf"
  url "https://github.com/mossmann/hackrf/archive/v2018.01.1.tar.gz"
  sha256 "84dbb5536d3aa5bd6b25d50df78d591e6c3431d752de051a17f4cb87b7963ec3"
  head "https://github.com/mossmann/hackrf.git"



  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "fftw"
  depends_on "libusb"

  def install
    cd "host" do
      system "cmake", ".", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    shell_output("#{bin}/hackrf_transfer", 1)
  end
end
