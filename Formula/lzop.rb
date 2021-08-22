class Lzop < Formula
  desc "File compressor"
  homepage "https://www.lzop.org/"
  url "https://dl.bintray.com/homebrew/mirror/lzop-1.04.tar.gz"
  mirror "https://www.lzop.org/download/lzop-1.04.tar.gz"
  sha256 "7e72b62a8a60aff5200a047eea0773a8fb205caf7acbe1774d95147f305a2f41"



  depends_on "lzo"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    path = testpath/"test"
    text = "This is Homebrew"
    path.write text

    system "#{bin}/lzop", "test"
    assert_predicate testpath/"test.lzo", :exist?
    rm path

    system "#{bin}/lzop", "-d", "test.lzo"
    assert_equal text, path.read
  end
end
