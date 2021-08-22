class Inspectrum < Formula
  desc "Offline radio signal analyser"
  homepage "https://github.com/miek/inspectrum"
  url "https://github.com/miek/inspectrum/archive/v0.2.2.tar.gz"
  sha256 "9e513101a59822c86b84cb7717f395c59bb27a6c192fe021cf4ffb7cf1d09c78"
  head "https://github.com/miek/inspectrum.git"



  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "fftw"
  depends_on "liquid-dsp"
  depends_on "qt"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    assert_match "-r, --rate <Hz>  Set sample rate.", shell_output("#{bin}/inspectrum -h").strip
  end
end
