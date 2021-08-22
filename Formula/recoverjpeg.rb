class Recoverjpeg < Formula
  desc "Tool to recover JPEG images from a file system image"
  homepage "https://www.rfc1149.net/devel/recoverjpeg.html"
  url "https://www.rfc1149.net/download/recoverjpeg/recoverjpeg-2.6.2.tar.gz"
  sha256 "d7f178f24099807d80483e970de76e728da4c81c52a8293ef615d7b184f56a07"



  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/recoverjpeg -V")
  end
end
