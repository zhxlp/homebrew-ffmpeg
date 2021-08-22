class Minizinc < Formula
  desc "Medium-level constraint modeling language"
  homepage "https://www.minizinc.org/"
  url "https://github.com/MiniZinc/libminizinc/archive/2.2.3.tar.gz"
  sha256 "1af08932adb9c965677b7f0a2aa8cff474b1e251f6295ff13c1444fd7a34b2df"
  head "https://github.com/MiniZinc/libminizinc.git", :branch => "develop"



  depends_on "cmake" => :build
  depends_on :arch => :x86_64

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "cmake", "--build", ".", "--target", "install"
    end
  end

  test do
    system bin/"mzn2doc", share/"examples/functions/warehouses.mzn"
  end
end
