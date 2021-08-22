class Innoextract < Formula
  desc "Tool to unpack installers created by Inno Setup"
  homepage "https://constexpr.org/innoextract/"
  url "https://constexpr.org/innoextract/files/innoextract-1.7.tar.gz"
  sha256 "c1efb732f2bc3a80065c5f51a0d4ea6027aebf528c609d3f336aea2055d2f0a4"
  head "https://github.com/dscharrer/innoextract.git"



  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "xz"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/innoextract", "--version"
  end
end
