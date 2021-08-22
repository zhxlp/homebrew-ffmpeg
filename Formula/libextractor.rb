class Libextractor < Formula
  desc "Library to extract meta data from files"
  homepage "https://www.gnu.org/software/libextractor/"
  url "https://ftp.gnu.org/gnu/libextractor/libextractor-1.8.tar.gz"
  mirror "https://ftpmirror.gnu.org/libextractor/libextractor-1.8.tar.gz"
  sha256 "e235a4aa2623fe458f8fcf1dcbb5be4f03df509aacec86a1de1fc7fcca582cfc"



  depends_on "pkg-config" => :build
  depends_on "libtool"

  conflicts_with "pkcrack", :because => "both install `extract` binaries"

  def install
    ENV.deparallelize

    system "./configure", "--disable-silent-rules",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    fixture = test_fixtures("test.png")
    assert_match /Keywords for file/, shell_output("#{bin}/extract #{fixture}")
  end
end
