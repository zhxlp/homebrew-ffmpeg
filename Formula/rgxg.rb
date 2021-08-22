class Rgxg < Formula
  desc "C library and command-line tool to generate (extended) regular expressions"
  homepage "https://rgxg.github.io"
  url "https://github.com/rgxg/rgxg/releases/download/v0.1.1/rgxg-0.1.1.tar.gz"
  sha256 "6566cd05d116475e98ceb57a5fdb25d8743f7381799aeb8e218433ff4fbb139f"



  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"rgxg", "range", "1", "10"
  end
end
