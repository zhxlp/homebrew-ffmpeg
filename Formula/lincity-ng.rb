class LincityNg < Formula
  desc "City simulation game"
  homepage "https://github.com/lincity-ng/lincity-ng/"
  url "https://github.com/lincity-ng/lincity-ng/archive/lincity-ng-2.0.tar.gz"
  sha256 "e05a2c1e1d682fbf289caecd0ea46ca84b0db9de43c7f1b5add08f0fdbf1456b"
  revision 2
  head "https://github.com/lincity-ng/lincity-ng.git"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "jam" => :build
  depends_on "pkg-config" => :build
  depends_on "physfs"
  depends_on "sdl"
  depends_on "sdl_gfx"
  depends_on "sdl_image"
  depends_on "sdl_mixer"
  depends_on "sdl_ttf"

  def install
    # Generate CREDITS
    system 'cat data/gui/creditslist.xml | grep -v "@" | cut -d\> -f2 | cut -d\< -f1 >CREDITS'
    system "./autogen.sh"
    system "./configure", "--disable-sdltest",
                          "--with-apple-opengl-framework",
                          "--prefix=#{prefix}",
                          "--datarootdir=#{pkgshare}"
    system "jam", "install"
    rm_rf ["#{pkgshare}/applications", "#{pkgshare}/pixmaps"]
  end

  def caveats; <<~EOS
    If you have problem with fullscreen, try running in windowed mode:
      lincity-ng -w
  EOS
  end

  test do
    (testpath/".lincity-ng").mkpath
    assert_match /lincity-ng version #{version}$/, shell_output("#{bin}/lincity-ng --version")
  end
end
