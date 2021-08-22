class Smpeg < Formula
  desc "SDL MPEG Player Library"
  homepage "https://icculus.org/smpeg/"
  url "svn://svn.icculus.org/smpeg/tags/release_0_4_5/", :revision => "399"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "sdl"

  def install
    args = %W[
      --prefix=#{prefix}
      --with-sdl-prefix=#{Formula["sdl"].opt_prefix}
      --disable-dependency-tracking
      --disable-debug
      --disable-gtk-player
      --disable-gtktest
      --disable-opengl-player
      --disable-sdltest
    ]

    system "./autogen.sh"
    system "./configure", *args
    system "make"
    # Install script is not +x by default for some reason
    chmod 0755, "./install-sh"
    system "make", "install"

    # Not present since we do not build with gtk+
    rm_f "#{man1}/gtv.1"
  end

  test do
    system "#{bin}/plaympeg", "--version"
  end
end
