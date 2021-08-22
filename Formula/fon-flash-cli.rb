class FonFlashCli < Formula
  desc "Flash La Fonera and Atheros chipset compatible devices"
  homepage "https://www.gargoyle-router.com/wiki/doku.php?id=fon_flash"
  url "https://www.gargoyle-router.com/downloads/src/gargoyle_1.10.0-src.tar.gz"
  version "1.10.0"
  sha256 "6397505b4a0c1f65c4823314d73fe6ad71f8c860d4582c581f47f16615597245"
  head "https://github.com/ericpaulbishop/gargoyle.git"



  # requires at least the 10.11 SDK
  depends_on :macos => :yosemite

  def install
    cd "fon-flash" do
      system "make", "fon-flash"
      bin.install "fon-flash"
    end
  end

  test do
    system "#{bin}/fon-flash"
  end
end
