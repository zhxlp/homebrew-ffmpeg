class Dgen < Formula
  desc "Sega Genesis / Mega Drive emulator"
  homepage "https://dgen.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/dgen/dgen/1.33/dgen-sdl-1.33.tar.gz"
  sha256 "99e2c06017c22873c77f88186ebcc09867244eb6e042c763bb094b02b8def61e"



  head do
    url "https://git.code.sf.net/p/dgen/dgen.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "libarchive"
  depends_on "sdl"

  def install
    args = %W[
      --disable-silent-rules
      --disable-dependency-tracking
      --disable-sdltest
      --prefix=#{prefix}
    ]
    system "./autogen.sh" if build.head?
    system "./configure", *args
    system "make", "install"
  end

  def caveats; <<~EOS
    If some keyboard inputs do not work, try modifying configuration:
      ~/.dgen/dgenrc
  EOS
  end

  test do
    assert_equal "DGen/SDL version #{version}", shell_output("#{bin}/dgen -v").chomp
  end
end
