class Castxml < Formula
  desc "C-family Abstract Syntax Tree XML Output"
  homepage "https://github.com/CastXML/CastXML"
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/c/castxml/castxml_0.1+git20180702.orig.tar.xz"
  mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/c/castxml/castxml_0.1+git20180702.orig.tar.xz"
  version "0.1+git20180702"
  sha256 "00c58b28523496fbeda731656bb022ad55e7c390609f189ebe03b4468292da40"
  head "https://github.com/CastXML/castxml.git"



  depends_on "cmake" => :build
  depends_on "llvm"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      int main() {
        return 0;
      }
    EOS
    system "#{bin}/castxml", "-c", "-x", "c++", "--castxml-cc-gnu", "clang++", "--castxml-gccxml", "-o", "test.xml", "test.cpp"
  end
end
