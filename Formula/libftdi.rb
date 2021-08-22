class Libftdi < Formula
  desc "Library to talk to FTDI chips"
  homepage "https://www.intra2net.com/en/developer/libftdi"
  url "https://www.intra2net.com/en/developer/libftdi/download/libftdi1-1.4.tar.bz2"
  sha256 "ec36fb49080f834690c24008328a5ef42d3cf584ef4060f3a35aa4681cb31b74"



  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "swig" => :build
  depends_on "libusb"

  def install
    mkdir "libftdi-build" do
      system "cmake", "..", "-DPYTHON_BINDINGS=OFF", *std_cmake_args
      system "make", "install"
      (libexec/"bin").install "examples/find_all"
    end
  end

  test do
    system libexec/"bin/find_all"
  end
end
