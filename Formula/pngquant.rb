class Pngquant < Formula
  desc "PNG image optimizing utility"
  homepage "https://pngquant.org/"
  url "https://pngquant.org/pngquant-2.12.2-src.tar.gz"
  sha256 "bb031c48039ee73ea0e60709bb9ab80c55bfa3a5920b798ea37a03f2757b099c"
  head "https://github.com/kornelski/pngquant.git"



  depends_on "pkg-config" => :build
  depends_on "rust" => :build
  depends_on "libpng"
  depends_on "little-cms2"

  def install
    system "cargo", "install", "--root", prefix, "--path", "."
    man1.install "pngquant.1"
  end

  test do
    system "#{bin}/pngquant", test_fixtures("test.png"), "-o", "out.png"
    assert_predicate testpath/"out.png", :exist?
  end
end
