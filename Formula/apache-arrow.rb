class ApacheArrow < Formula
  desc "Columnar in-memory analytics layer designed to accelerate big data"
  homepage "https://arrow.apache.org/"
  url "https://www.apache.org/dyn/closer.cgi?path=arrow/arrow-0.12.0/apache-arrow-0.12.0.tar.gz"
  sha256 "34dae7e4dde9274e9a52610683e78a80f3ca312258ad9e9f2c0973cf44247a98"



  depends_on "autoconf" => :build
  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "flatbuffers"
  depends_on "lz4"
  depends_on "numpy"
  depends_on "protobuf"
  depends_on "python"
  depends_on "snappy"
  depends_on "thrift"
  depends_on "zstd"

  def install
    ENV.cxx11
    args = %W[
      -DARROW_ORC=ON
      -DARROW_PARQUET=ON
      -DARROW_PLASMA=ON
      -DARROW_PROTOBUF_USE_SHARED=ON
      -DARROW_PYTHON=ON
      -DFLATBUFFERS_HOME=#{Formula["flatbuffers"].prefix}
      -DLZ4_HOME=#{Formula["lz4"].prefix}
      -DPROTOBUF_HOME=#{Formula["protobuf"].prefix}
      -DPYTHON_EXECUTABLE=#{Formula["python"].bin/"python3"}
      -DSNAPPY_HOME=#{Formula["snappy"].prefix}
      -DTHRIFT_HOME=#{Formula["thrift"].prefix}
      -DZSTD_HOME=#{Formula["zstd"].prefix}
    ]

    mkdir "build"
    cd "build" do
      system "cmake", "../cpp", *std_cmake_args, *args
      system "make"
      system "make", "install"
    end
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include "arrow/api.h"
      int main(void) {
        arrow::int64();
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++11", "-I#{include}", "-L#{lib}", "-larrow", "-o", "test"
    system "./test"
  end
end
