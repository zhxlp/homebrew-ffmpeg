class Pkgdiff < Formula
  desc "Tool for analyzing changes in software packages (e.g. RPM, DEB, TAR.GZ)"
  homepage "https://lvc.github.io/pkgdiff/"
  url "https://github.com/lvc/pkgdiff/archive/1.7.2.tar.gz"
  sha256 "d0ef5c8ef04f019f00c3278d988350201becfbe40d04b734defd5789eaa0d321"



  depends_on "binutils"
  depends_on "gawk"
  depends_on "wdiff"

  def install
    system "perl", "Makefile.pl", "--install", "--prefix=#{prefix}"
  end

  test do
    system bin/"pkgdiff"
  end
end
