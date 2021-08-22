class Libbpg < Formula
  desc "Image format meant to improve on JPEG quality and file size"
  homepage "https://bellard.org/bpg/"
  url "https://bellard.org/bpg/libbpg-0.9.8.tar.gz"
  sha256 "c0788e23bdf1a7d36cb4424ccb2fae4c7789ac94949563c4ad0e2569d3bf0095"



  depends_on "cmake" => :build
  depends_on "yasm" => :build
  depends_on "jpeg"
  depends_on "libpng"

  def install
    bin.mkpath
    system "make", "install", "prefix=#{prefix}", "CONFIG_APPLE=y"
    pkgshare.install Dir["html/bpgdec*.js"]
  end

  test do
    system "#{bin}/bpgenc", test_fixtures("test.png")
  end
end
