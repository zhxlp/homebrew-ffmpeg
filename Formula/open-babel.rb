class OpenBabel < Formula
  desc "Chemical toolbox"
  homepage "https://openbabel.org"
  url "https://github.com/openbabel/openbabel/archive/openbabel-2-4-1.tar.gz"
  version "2.4.1"
  sha256 "594c7f8a83f3502381469d643f7b185882da1dd4bc2280c16502ef980af2a776"
  revision 1
  head "https://github.com/openbabel/openbabel.git"



  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "eigen"

  def install
    args = std_cmake_args + %w[
      -DCAIRO_LIBRARY:FILEPATH=
    ]

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/obabel", "-:'C1=CC=CC=C1Br'", "-omol"
  end
end
