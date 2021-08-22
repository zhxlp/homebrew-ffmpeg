class Moe < Formula
  desc "Console text editor for ISO-8859 and ASCII"
  homepage "https://www.gnu.org/software/moe/moe.html"
  url "https://ftp.gnu.org/gnu/moe/moe-1.9.tar.lz"
  mirror "https://ftpmirror.gnu.org/moe/moe-1.9.tar.lz"
  sha256 "18919e9ffae08f34d8beb3a26fc5a595614e0aff34866e79420ca81881ff4ef3"



  def install
    # Fix compilation bug with Xcode 9
    # https://lists.gnu.org/archive/html/bug-moe/2017-10/msg00000.html
    inreplace "window_vector.cc", "{ year_string.insert( 0U, 1,",
                                  "{ year_string.insert( 0U, 1U,"

    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/moe", "--version"
  end
end
