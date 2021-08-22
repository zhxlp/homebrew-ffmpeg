class Icemon < Formula
  desc "Icecream GUI Monitor"
  homepage "https://github.com/icecc/icemon"
  url "https://github.com/icecc/icemon/archive/v3.2.0.tar.gz"
  sha256 "b7ed29c3638c93fbc974d56c85afbf0bfeca6c37ed0522af57415a072839b448"



  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "icecream"
  depends_on "lzo"
  depends_on "qt"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/icemon", "--version"
  end
end
