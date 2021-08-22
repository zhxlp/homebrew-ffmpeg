class Metashell < Formula
  desc "Metaprogramming shell for C++ templates"
  homepage "http://metashell.org"
  url "https://github.com/metashell/metashell/archive/v4.0.0.tar.gz"
  sha256 "02a88204fe36428cc6c74453059e8c399759d4306e8156d0920aefa4c07efc64"



  depends_on "cmake" => :build

  def install
    ENV.cxx11

    # Build internal Clang
    mkdir "3rd/templight/build" do
      system "cmake", "../llvm", "-DLLVM_ENABLE_TERMINFO=OFF", *std_cmake_args
      system "make", "templight"
    end

    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    (testpath/"test.hpp").write <<~EOS
      template <class T> struct add_const { using type = const T; };
      add_const<int>::type
    EOS
    output = shell_output("cat #{testpath}/test.hpp | #{bin}/metashell -H")
    assert_match "const int", output
  end
end
