class Ktoblzcheck < Formula
  desc "Library for German banks"
  homepage "https://ktoblzcheck.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/ktoblzcheck/ktoblzcheck-1.49.tar.gz"
  sha256 "e8971bc6689ea72b174c194bd43ba2c0b65112b0c3f9fd2371562e0c3ab57d29"



  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    ENV.deparallelize
    system "make", "install"
  end

  test do
    assert_match /Ok/, shell_output("#{bin}/ktoblzcheck --outformat=oneline 10000000 123456789", 0)
    assert_match /unknown/, shell_output("#{bin}/ktoblzcheck --outformat=oneline 12345678 100000000", 3)
  end
end
