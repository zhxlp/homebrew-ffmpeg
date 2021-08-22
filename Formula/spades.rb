class Spades < Formula
  desc "De novo genome sequence assembly"
  homepage "http://cab.spbu.ru/software/spades/"
  url "http://cab.spbu.ru/files/release3.13.0/SPAdes-3.13.0.tar.gz"
  mirror "https://github.com/ablab/spades/releases/download/v3.13.0/SPAdes-3.13.0.tar.gz"
  sha256 "c63442248c4c712603979fa70503c2bff82354f005acda2abc42dd5598427040"



  depends_on "cmake" => :build
  depends_on "gcc"

  fails_with :clang # no OpenMP support

  def install
    mkdir "src/build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    assert_match "TEST PASSED CORRECTLY", shell_output("#{bin}/spades.py --test")
  end
end
