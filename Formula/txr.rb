class Txr < Formula
  desc "Original, new programming language for convenient data munging"
  homepage "https://www.nongnu.org/txr/"
  url "http://www.kylheku.com/cgit/txr/snapshot/txr-198.tar.bz2"
  sha256 "82f53cd14b2cd60a9d0faed49ca14d42f5e212d2f05310c54b8a041a9d28ebf4"
  head "http://www.kylheku.com/git/txr", :using => :git



  def install
    ENV.deparallelize
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    assert_equal "3", shell_output(bin/"txr -p '(+ 1 2)'").chomp
  end
end
