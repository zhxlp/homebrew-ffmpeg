class Gcal < Formula
  desc "Program for calculating and printing calendars"
  homepage "https://www.gnu.org/software/gcal/"
  url "https://ftp.gnu.org/gnu/gcal/gcal-4.1.tar.xz"
  mirror "https://ftpmirror.gnu.org/gcal/gcal-4.1.tar.xz"
  sha256 "91b56c40b93eee9bda27ec63e95a6316d848e3ee047b5880ed71e5e8e60f61ab"



  def install
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make", "install"
    system "make", "-C", "doc/en", "html"
    doc.install "doc/en/gcal.html"
  end

  test do
    date = shell_output("date +%Y")
    assert_match date, shell_output("#{bin}/gcal")
  end
end
