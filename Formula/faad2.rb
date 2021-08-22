class Faad2 < Formula
  desc "ISO AAC audio decoder"
  homepage "https://www.audiocoding.com/faad2.html"
  url "https://downloads.sourceforge.net/project/faac/faad2-src/faad2-2.8.0/faad2-2.8.8.tar.gz"
  sha256 "985c3fadb9789d2815e50f4ff714511c79c2710ac27a4aaaf5c0c2662141426d"



  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match "infile.mp4", shell_output("#{bin}/faad -h", 1)
  end
end
