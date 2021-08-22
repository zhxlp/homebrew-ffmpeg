class Qjson < Formula
  desc "Map JSON to QVariant objects"
  homepage "https://qjson.sourceforge.io"
  url "https://github.com/flavio/qjson/archive/0.9.0.tar.gz"
  sha256 "e812617477f3c2bb990561767a4cd8b1d3803a52018d4878da302529552610d4"
  revision 1



  depends_on "cmake" => :build
  depends_on "qt"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <qjson-qt5/parser.h>
      int main() {
        QJson::Parser parser;
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-o", "test", "-std=c++11", "-I#{include}",
                    "-L#{lib}", "-lqjson-qt5",
                    "-I#{Formula["qt"].opt_include}",
                    "-F#{Formula["qt"].opt_lib}", "-framework", "QtCore"
    system "./test"
  end
end
