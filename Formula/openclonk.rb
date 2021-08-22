class Openclonk < Formula
  desc "Multiplayer action game"
  homepage "https://www.openclonk.org/"
  url "https://www.openclonk.org/builds/release/7.0/openclonk-7.0-src.tar.bz2"
  sha256 "bc1a231d72774a7aa8819e54e1f79be27a21b579fb057609398f2aa5700b0732"
  revision 2
  head "https://github.com/openclonk/openclonk", :using => :git



  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "freealut"
  depends_on "freetype"
  depends_on "glew"
  depends_on "jpeg"
  depends_on "libogg"
  depends_on "libpng"
  depends_on "libvorbis"
  # Requires some C++14 features missing in Mavericks
  depends_on :macos => :yosemite

  def install
    ENV.cxx11
    system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "install"
    bin.write_exec_script "#{prefix}/openclonk.app/Contents/MacOS/openclonk"
    bin.install Dir[prefix/"c4*"]
  end

  test do
    system bin/"c4group"
  end
end
