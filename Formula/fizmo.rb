class Fizmo < Formula
  desc "Z-Machine interpreter"
  homepage "https://fizmo.spellbreaker.org"
  url "https://fizmo.spellbreaker.org/source/fizmo-0.8.5.tar.gz"
  sha256 "1c259a29b21c9f401c12fc24d555aca4f4ff171873be56fb44c0c9402c61beaa"
  revision 1



  depends_on "pkg-config" => :build
  depends_on "freetype"
  depends_on "jpeg"
  depends_on "libpng"
  depends_on "libsndfile"
  depends_on "sdl2"
  depends_on :x11

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules"
    system "make", "install"
  end

  test do
    system "#{bin}/fizmo-console", "--help"
    # Unable to test headless ncursew client
    # https://github.com/Homebrew/homebrew-games/pull/366
    # system "#{bin}/fizmo-ncursesw", "--help"
    system "#{bin}/fizmo-sdl2", "--help"
  end
end
