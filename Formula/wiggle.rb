class Wiggle < Formula
  desc "Program for applying patches with conflicting changes"
  homepage "https://neil.brown.name/blog/20100324064620"
  url "https://neil.brown.name/wiggle/wiggle-1.1.tar.gz"
  sha256 "3da3cf6a456dd1415d2644e345f9831eb2912c6fa8dfa5d63d9bf49d744abff3"



  def install
    system "make", "OptDbg=#{ENV.cflags}", "wiggle", "wiggle.man", "test"
    bin.install "wiggle"
    man1.install "wiggle.1"
  end

  test do
    system "#{bin}/wiggle", "--version"
  end
end
