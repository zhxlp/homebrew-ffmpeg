class Nudoku < Formula
  desc "ncurses based sudoku game"
  homepage "https://jubalh.github.io/nudoku/"
  url "https://github.com/jubalh/nudoku/archive/1.0.0.tar.gz"
  sha256 "80fb9996c28642920951c20cfd5ca6e370d75240255bc6f11067ae68b6e44eca"
  head "https://github.com/jubalh/nudoku.git"



  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "autoreconf", "-fiv"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match "nudoku version #{version}", shell_output("#{bin}/nudoku -v")
  end
end
