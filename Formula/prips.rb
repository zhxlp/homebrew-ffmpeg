class Prips < Formula
  desc "Print the IP addresses in a given range"
  homepage "https://devel.ringlet.net/sysutils/prips/"
  url "https://devel.ringlet.net/files/sys/prips/prips-1.1.0.tar.xz"
  mirror "https://deb.debian.org/debian/pool/main/p/prips/prips_1.1.0.orig.tar.xz"
  sha256 "f6f85ee0234218e426cb72b27411902a55e1daa02f22d1e7270ff41e07fe0444"



  def install
    system "make"
    bin.install "prips"
    man1.install "prips.1"
  end

  test do
    assert_equal "127.0.0.0\n127.0.0.1",
      shell_output("#{bin}/prips 127.0.0.0/31").strip
  end
end
