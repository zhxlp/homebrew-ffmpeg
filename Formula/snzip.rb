class Snzip < Formula
  desc "Compression/decompression tool based on snappy"
  homepage "https://github.com/kubo/snzip"
  url "https://bintray.com/artifact/download/kubo/generic/snzip-1.0.4.tar.gz"
  sha256 "a45081354715d48ed31899508ebed04a41d4b4a91dca37b79fc3b8ee0c02e25e"
  revision 2



  depends_on "snappy"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.out").write "test"
    system "#{bin}/snzip", "test.out"
    system "#{bin}/snzip", "-d", "test.out.sz"
  end
end
