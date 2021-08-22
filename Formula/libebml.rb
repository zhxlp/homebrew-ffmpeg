class Libebml < Formula
  desc "Sort of a sbinary version of XML"
  homepage "https://www.matroska.org/"
  url "https://dl.matroska.org/downloads/libebml/libebml-1.3.6.tar.xz"
  sha256 "1e5a7a7820c493aa62b0f35e15b4233c792cc03458c55ebdfa7a6521e4b43e9e"
  head "https://github.com/Matroska-Org/libebml.git"



  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", "-DBUILD_SHARED_LIBS=ON", *std_cmake_args
      system "make", "install"
    end
  end
end
