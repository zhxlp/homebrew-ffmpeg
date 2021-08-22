class Physfs < Formula
  desc "Library to provide abstract access to various archives"
  homepage "https://icculus.org/physfs/"
  url "https://icculus.org/physfs/downloads/physfs-3.0.1.tar.bz2"
  sha256 "b77b9f853168d9636a44f75fca372b363106f52d789d18a2f776397bf117f2f1"
  head "https://hg.icculus.org/icculus/physfs/", :using => :hg



  depends_on "cmake" => :build

  def install
    mkdir "macbuild" do
      args = std_cmake_args
      args << "-DPHYSFS_BUILD_TEST=TRUE"
      args << "-DPHYSFS_BUILD_WX_TEST=FALSE" unless build.head?
      system "cmake", "..", *args
      system "make", "install"
    end
  end

  test do
    (testpath/"test.txt").write "homebrew"
    system "zip", "test.zip", "test.txt"
    (testpath/"test").write <<~EOS
      addarchive test.zip 1
      cat test.txt
    EOS
    assert_match /Successful\.\nhomebrew/, shell_output("#{bin}/test_physfs < test 2>&1")
  end
end
