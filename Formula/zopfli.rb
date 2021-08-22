class Zopfli < Formula
  desc "New zlib (gzip, deflate) compatible compressor"
  homepage "https://github.com/google/zopfli"
  url "https://github.com/google/zopfli/archive/zopfli-1.0.2.tar.gz"
  sha256 "4a570307c37172d894ec4ef93b6e8e3aacc401e78cbcc51cf85b212dbc379a55"
  head "https://github.com/google/zopfli.git"



  def install
    system "make", "zopfli", "zopflipng"
    bin.install "zopfli", "zopflipng"
  end

  test do
    system "#{bin}/zopfli"
    system "#{bin}/zopflipng", test_fixtures("test.png"), "#{testpath}/out.png"
    assert_predicate testpath/"out.png", :exist?
  end
end
