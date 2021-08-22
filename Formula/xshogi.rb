class Xshogi < Formula
  desc "X11 interface for GNU Shogi"
  homepage "https://www.gnu.org/software/gnushogi/"
  url "https://ftp.gnu.org/gnu/gnushogi/xshogi-1.4.2.tar.gz"
  mirror "https://ftpmirror.gnu.org/gnushogi/xshogi-1.4.2.tar.gz"
  sha256 "2e2f1145e3317143615a764411178f538bd54945646b14fc2264aaeaa105dab6"



  depends_on "gnu-shogi"
  depends_on :x11

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking"
    system "make", "install"
  end
end
