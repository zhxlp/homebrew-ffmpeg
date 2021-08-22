class Frobtads < Formula
  desc "TADS interpreter and compilers"
  homepage "https://www.tads.org/frobtads.htm"
  url "https://github.com/realnc/frobtads/releases/download/1.2.4/frobtads-1.2.4.tar.bz2"
  sha256 "705be5849293844f499a85280e793941b0eacb362b90d49d85ae8308e4c5b63c"



  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match /FrobTADS #{version}$/, shell_output("#{bin}/frob --version")
  end
end
