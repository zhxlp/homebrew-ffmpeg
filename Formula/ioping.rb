class Ioping < Formula
  desc "Tool to monitor I/O latency in real time"
  homepage "https://github.com/koct9i/ioping"
  url "https://github.com/koct9i/ioping/archive/v1.1.tar.gz"
  sha256 "f17d1c88d51cf1e364d9cde878f94b3e4cc56b0adb76e138e4deb5c837f449b6"
  head "https://github.com/koct9i/ioping.git"



  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/ioping", "-c", "1", testpath
  end
end
