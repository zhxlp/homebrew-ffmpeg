class Sdl2 < Formula
  desc "Low-level access to audio, keyboard, mouse, joystick, and graphics"
  homepage "https://www.libsdl.org/"
  url "https://libsdl.org/release/SDL2-2.0.9.tar.gz"
  sha256 "255186dc676ecd0c1dbf10ec8a2cc5d6869b5079d8a38194c2aecdff54b324b1"



  head do
    url "https://hg.libsdl.org/SDL", :using => :hg

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  # Upstream commit to fix issue with library version numbers
  # https://hg.libsdl.org/SDL/rev/d274fa9731b1
  patch do
    url "https://github.com/libsdl-org/SDL/commit/5e1531944ce66135e15cf1663671d0bea6a44917.diff"
    sha256 "651ab7d83d907b6607d7b6177a5d571909c9cd8d1cde1028a149f75db1ab20d2"
  end

  def install
    # we have to do this because most build scripts assume that all sdl modules
    # are installed to the same prefix. Consequently SDL stuff cannot be
    # keg-only but I doubt that will be needed.
    inreplace %w[sdl2.pc.in sdl2-config.in], "@prefix@", HOMEBREW_PREFIX

    system "./autogen.sh" if build.head?

    args = %W[--prefix=#{prefix} --without-x]
    system "./configure", *args
    system "make", "install"
  end

  test do
    system bin/"sdl2-config", "--version"
  end
end
