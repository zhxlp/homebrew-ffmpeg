class CernNdiff < Formula
  desc "Numerical diff tool"
  # Note: ndiff is a sub-project of Mad-X at the moment..
  homepage "https://mad.web.cern.ch/mad/"
  url "https://github.com/MethodicalAcceleratorDesign/MAD-X/archive/v5.04.02.tar.gz"
  sha256 "4bd4670e63fb99521f17702b99913bb767b31953680937a64a97314f5b2e715b"
  head "https://github.com/MethodicalAcceleratorDesign/MAD-X.git"



  depends_on "cmake" => :build

  def install
    cd "tools/numdiff" do
      system "cmake", ".", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    (testpath/"lhs.txt").write("0.0 2e-3 0.003")
    (testpath/"rhs.txt").write("1e-7 0.002 0.003")
    (testpath/"test.cfg").write("*   * abs=1e-6")
    system "#{bin}/ndiff", "lhs.txt", "rhs.txt", "test.cfg"
  end
end
