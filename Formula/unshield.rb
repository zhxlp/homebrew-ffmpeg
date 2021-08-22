class Unshield < Formula
  desc "Extract files from InstallShield cabinet files"
  homepage "https://github.com/twogood/unshield"
  url "https://github.com/twogood/unshield/archive/1.4.3.tar.gz"
  sha256 "aa8c978dc0eb1158d266eaddcd1852d6d71620ddfc82807fe4bf2e19022b7bab"
  head "https://github.com/twogood/unshield.git"



  depends_on "cmake" => :build
  depends_on "openssl"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system bin/"unshield", "-V"
  end
end
