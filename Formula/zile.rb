class Zile < Formula
  desc "Text editor development kit"
  homepage "https://www.gnu.org/software/zile/"
  url "https://ftp.gnu.org/gnu/zile/zile-2.4.14.tar.gz"
  mirror "https://ftpmirror.gnu.org/zile/zile-2.4.14.tar.gz"
  sha256 "7a78742795ca32480f2bab697fd5e328618d9997d6f417cf1b14e9da9af26b74"
  revision 2



  depends_on "help2man" => :build
  depends_on "pkg-config" => :build
  depends_on "bdw-gc"

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zile --version")
  end
end
