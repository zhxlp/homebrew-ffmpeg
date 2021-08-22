class Astyle < Formula
  desc "Source code beautifier for C, C++, C#, and Java"
  homepage "https://astyle.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/astyle/astyle/astyle%203.1/astyle_3.1_macos.tar.gz"
  sha256 "c4eebbe082eb2cb98f90aafcce3da2daeb774dd092e4cf8b728102fded8d1dcf"
  head "https://svn.code.sf.net/p/astyle/code/trunk/AStyle"



  def install
    cd "src" do
      system "make", "CXX=#{ENV.cxx}", "-f", "../build/mac/Makefile"
      bin.install "bin/astyle"
    end
  end

  test do
    (testpath/"test.c").write("int main(){return 0;}\n")
    system "#{bin}/astyle", "--style=gnu", "--indent=spaces=4",
           "--lineend=linux", "#{testpath}/test.c"
    assert_equal File.read("test.c"), <<~EOS
      int main()
      {
          return 0;
      }
    EOS
  end
end
