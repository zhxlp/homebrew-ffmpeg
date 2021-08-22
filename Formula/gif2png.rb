class Gif2png < Formula
  desc "Convert GIFs to PNGs"
  homepage "http://www.catb.org/~esr/gif2png/"
  url "http://www.catb.org/~esr/gif2png/gif2png-2.5.11.tar.gz"
  sha256 "40483169d2de06f632ada1de780c36f63325844ec62892b1652193f77fc508f7"



  depends_on "libpng"

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    pipe_output "#{bin}/gif2png -O", File.read(test_fixtures("test.gif"))
  end
end
