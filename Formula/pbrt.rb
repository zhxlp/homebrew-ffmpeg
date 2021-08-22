class Pbrt < Formula
  desc "Physically based rendering"
  homepage "https://pbrt.org/"
  url "https://github.com/mmp/pbrt-v2/archive/2.0.342.tar.gz"
  sha256 "397941435d4b217cd4a4adaca12ab6add9a960d46984972f259789d1462fb6d5"
  revision 1



  depends_on "flex"
  depends_on "openexr"

  def install
    system "make", "-C", "src"
    prefix.install "src/bin"
  end

  test do
    system "#{bin}/pbrt", "--version"
  end
end
