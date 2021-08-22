class ExactImage < Formula
  desc "Image processing library"
  homepage "https://exactcode.com/opensource/exactimage/"
  url "https://dl.exactcode.de/oss/exact-image/exact-image-1.0.1.tar.bz2"
  sha256 "3bf45d21e653f6a4664147eb4ba29178295d530400d5e16a2ab19ac79f62b76c"



  depends_on "pkg-config" => :build
  depends_on "libagg"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/bardecode"
  end
end
