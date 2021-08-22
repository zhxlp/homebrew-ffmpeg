class SdlMixer < Formula
  desc "Sample multi-channel audio mixer library"
  homepage "https://www.libsdl.org/projects/SDL_mixer/"
  url "https://www.libsdl.org/projects/SDL_mixer/release/SDL_mixer-1.2.12.tar.gz"
  sha256 "1644308279a975799049e4826af2cfc787cad2abb11aa14562e402521f86992a"
  revision 3



  depends_on "pkg-config" => :build
  depends_on "libmikmod"
  depends_on "libogg"
  depends_on "libvorbis"
  depends_on "sdl"

  # Source file for sdl_mixer example
  resource "playwave" do
    url "https://hg.libsdl.org/SDL_mixer/raw-file/a4e9c53d9c30/playwave.c"
    sha256 "92f686d313f603f3b58431ec1a3a6bf29a36e5f792fb78417ac3d5d5a72b76c9"
  end

  def install
    inreplace "SDL_mixer.pc.in", "@prefix@", HOMEBREW_PREFIX

    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --enable-music-ogg
      --disable-music-ogg-shared
      --disable-music-mod-shared
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    testpath.install resource("playwave")
    system ENV.cc, "-o", "playwave", "playwave.c", "-I#{include}/SDL",
                   "-I#{Formula["sdl"].opt_include}/SDL",
                   "-L#{lib}", "-lSDL_mixer",
                   "-L#{Formula["sdl"].lib}", "-lSDLmain", "-lSDL",
                   "-Wl,-framework,Cocoa"
    system "SDL_VIDEODRIVER=dummy SDL_AUDIODRIVER=disk ./playwave #{test_fixtures("test.wav")}"
    assert_predicate testpath/"sdlaudio.raw", :exist?
  end
end
