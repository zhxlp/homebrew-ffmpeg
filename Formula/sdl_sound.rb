class SdlSound < Formula
  desc "Library to decode several popular sound file formats"
  homepage "https://icculus.org/SDL_sound/"
  url "https://icculus.org/SDL_sound/downloads/SDL_sound-1.0.3.tar.gz"
  mirror "https://mirrors.ocf.berkeley.edu/debian/pool/main/s/sdl-sound1.2/sdl-sound1.2_1.0.3.orig.tar.gz"
  sha256 "3999fd0bbb485289a52be14b2f68b571cb84e380cc43387eadf778f64c79e6df"
  revision 1



  head do
    url "https://hg.icculus.org/icculus/SDL_sound", :using => :hg

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "libogg"
  depends_on "libvorbis"
  depends_on "sdl"

  def install
    if build.head?
      inreplace "bootstrap", "/usr/bin/glibtoolize", "#{Formula["libtool"].opt_bin}/glibtoolize"
      system "./bootstrap"
    end

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-sdltest"
    system "make"
    system "make", "check"
    system "make", "install"
  end
end
