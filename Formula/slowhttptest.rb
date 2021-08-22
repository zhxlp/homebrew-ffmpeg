class Slowhttptest < Formula
  desc "Simulates application layer denial of service attacks"
  homepage "https://github.com/shekyan/slowhttptest"
  url "https://github.com/shekyan/slowhttptest/archive/v1.7.tar.gz"
  sha256 "9fd3ce4b0a7dda2e96210b1e438c0c8ec924a13e6699410ac8530224b29cfb8e"
  head "https://github.com/shekyan/slowhttptest.git"



  depends_on "openssl"

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/slowhttptest", "-u", "https://google.com",
                                  "-p", "1", "-r", "1", "-l", "1", "-i", "1"
  end
end
