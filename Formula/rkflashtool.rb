class Rkflashtool < Formula
  desc "Tools for flashing Rockchip devices"
  homepage "https://sourceforge.net/projects/rkflashtool/"
  url "https://downloads.sourceforge.net/project/rkflashtool/rkflashtool-6.1/rkflashtool-6.1-src.tar.bz2"
  sha256 "2bc0ec580caa790b0aee634388a9110a429baf4b93ff2c4fce3d9ab583f51339"
  head "https://git.code.sf.net/p/rkflashtool/Git.git"



  depends_on "pkg-config" => :build
  depends_on "libusb"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"input.file").write "ABCD"
    system bin/"rkcrc", "input.file", "output.file"
    result = shell_output("cat output.file")
    result.force_encoding("UTF-8") if result.respond_to?(:force_encoding)
    assert_equal "ABCD\264\366\a\t", result
  end
end
