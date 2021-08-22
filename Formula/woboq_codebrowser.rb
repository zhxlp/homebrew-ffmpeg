class WoboqCodebrowser < Formula
  desc "Generate HTML from C++ Code"
  homepage "https://code.woboq.org/"
  url "https://github.com/woboq/woboq_codebrowser/archive/2.1.tar.gz"
  sha256 "f7c803260a9a79405c4c2c561443c49702811f38dcf1081238ef024a6654caa0"
  revision 3



  depends_on "cmake" => :build
  depends_on "llvm@6"

  def install
    args = std_cmake_args + %W[
      -DLLVM_CONFIG_EXECUTABLE=#{Formula["llvm@6"].opt_bin}/llvm-config
      -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
    ]
    system "cmake", ".", *args
    system "make"
    bin.install "indexgenerator/codebrowser_indexgenerator",
                "generator/codebrowser_generator"
    prefix.install "data"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      int main() {
      printf(\"hi!\");
      }
    EOS
    system "#{bin}/codebrowser_generator", "-o=#{testpath}", "-p",
                                           "test:#{testpath}",
                                           "#{testpath}/test.c",
                                           "--", "clang", "#{testpath}/test.c"

    assert_predicate testpath/"test/test.c.html", :exist?
    assert_predicate testpath/"refs/printf", :exist?
    assert_predicate testpath/"fnSearch", :exist?
    assert_predicate testpath/"fileIndex", :exist?
  end
end
