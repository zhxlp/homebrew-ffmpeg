class Sfk < Formula
  desc "Command-line tools collection"
  homepage "http://stahlworks.com/dev/swiss-file-knife.html"
  url "https://downloads.sourceforge.net/project/swissfileknife/1-swissfileknife/1.9.2.0/sfk-1.9.2.tar.gz"
  version "1.9.2.0"
  sha256 "4537d033edfe6feb0bbafdcf157646a19951b8ef9056898718674d39a3c088d7"



  def install
    ENV.libstdcxx

    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/sfk", "ip"
  end
end
