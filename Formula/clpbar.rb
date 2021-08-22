class Clpbar < Formula
  desc "Command-line progress bar"
  homepage "https://clpbar.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/clpbar/clpbar/bar-1.11.1/bar_1.11.1.tar.gz"
  sha256 "fa0f5ec5c8400316c2f4debdc6cdcb80e186e668c2e4471df4fec7bfcd626503"



  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--program-prefix='clp'"
    system "make", "install"
  end

  test do
    output = shell_output("dd if=/dev/zero bs=1024 count=5 | #{bin}/clpbar 2>&1")
    assert_match "Copied: 5120B (5.0KB)", output
  end
end
