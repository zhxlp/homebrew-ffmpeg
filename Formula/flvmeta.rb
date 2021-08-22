class Flvmeta < Formula
  desc "Manipulate Adobe flash video files (FLV)"
  homepage "https://www.flvmeta.com/"
  url "https://www.flvmeta.com/download.php?file=flvmeta-1.2.1.tar.gz"
  sha256 "4b48afc2db8b0ff1c86861bc09a58481bc241d93b879b6f915fbf695fc4bff51"
  head "https://github.com/noirotm/flvmeta.git"



  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system bin/"flvmeta", "-V"
  end
end
