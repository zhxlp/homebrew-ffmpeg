class Securefs < Formula
  desc "Filesystem with transparent authenticated encryption"
  homepage "https://github.com/netheril96/securefs"
  url "https://github.com/netheril96/securefs/archive/0.8.2.tar.gz"
  sha256 "831c013bb8a5b32e21dca0e2503cf770dcd3c0c4ed9264769d0ab101707829ca"
  head "https://github.com/netheril96/securefs.git"



  depends_on "cmake" => :build
  depends_on :osxfuse

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/securefs", "version" # The sandbox prevents a more thorough test
  end
end
