class Snappystream < Formula
  desc "C++ snappy stream realization (compatible with snappy)"
  homepage "https://github.com/hoxnox/snappystream"
  url "https://github.com/hoxnox/snappystream/archive/1.0.0.tar.gz"
  sha256 "a50a1765eac1999bf42d0afd46d8704e8c4040b6e6c05dcfdffae6dcd5c6c6b8"
  head "https://github.com/hoxnox/snappystream.git"



  depends_on "cmake" => :build
  depends_on "snappy"

  def install
    system "cmake", ".", *std_cmake_args, "-DBUILD_TESTS=ON"
    system "make", "all", "test", "install"
  end

  test do
    (testpath/"test.cxx").write <<~EOS
      #include <iostream>
      #include <fstream>
      #include <iterator>
      #include <algorithm>
      #include <snappystream.hpp>

      int main()
      {
        { std::ofstream ofile("snappy-file.dat");
          snappy::oSnappyStream osnstrm(ofile);
          std::cin >> std::noskipws;
          std::copy(std::istream_iterator<char>(std::cin), std::istream_iterator<char>(), std::ostream_iterator<char>(osnstrm));
        }
        { std::ifstream ifile("snappy-file.dat");
          snappy::iSnappyStream isnstrm(ifile);
          isnstrm >> std::noskipws;
          std::copy(std::istream_iterator<char>(isnstrm), std::istream_iterator<char>(), std::ostream_iterator<char>(std::cout));
        }
      }
    EOS
    system ENV.cxx, "test.cxx", "-o", "test",
                    "-L#{Formula["snappy"].opt_lib}", "-lsnappy",
                    "-L#{lib}", "-lsnappystream"
    system "./test < #{__FILE__} > out.dat && diff #{__FILE__} out.dat"
  end
end
