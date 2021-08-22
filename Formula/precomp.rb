class Precomp < Formula
  desc "Command-line precompressor to achieve better compression"
  homepage "http://schnaader.info/precomp.php"
  url "https://github.com/schnaader/precomp-cpp/archive/v0.4.6.tar.gz"
  sha256 "673b9ceb0df62abb5ef12ab0600a18fc3b82003cc9af5e1cc2f196237ed350d3"
  head "https://github.com/schnaader/precomp-cpp.git"



  def install
    # Seems like Yosemite does not like the -s flag
    inreplace "Makefile", " -s ", " "

    system "make"
    bin.install "precomp"
  end

  test do
    cp "#{bin}/precomp", testpath/"precomp"
    system "gzip", "-1", testpath/"precomp"

    system "#{bin}/precomp", testpath/"precomp.gz"
    rm testpath/"precomp.gz", :force => true
    system "#{bin}/precomp", "-r", testpath/"precomp.pcf"
    system "gzip", "-d", testpath/"precomp.gz"
  end
end
