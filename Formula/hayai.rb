class Hayai < Formula
  desc "C++ benchmarking framework inspired by the googletest framework"
  homepage "https://bruun.co/2012/02/07/easy-cpp-benchmarking"
  url "https://github.com/nickbruun/hayai/archive/v1.0.2.tar.gz"
  sha256 "e30e69b107361c132c831a2c8b2040ea51225bb9ed50675b51099435b8cd6594"



  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <hayai/hayai.hpp>
      #include <iostream>
      int main() {
        hayai::Benchmarker::RunAllTests();
        return 0;
      }

      BENCHMARK(HomebrewTest, TestBenchmark, 1, 1)
      {
        std::cout << "Hayai works!" << std::endl;
      }
    EOS

    system ENV.cxx, "test.cpp", "-L#{lib}", "-lhayai_main", "-o", "test"
    system "./test"
  end
end
