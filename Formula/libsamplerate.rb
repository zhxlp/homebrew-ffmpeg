class Libsamplerate < Formula
  desc "Library for sample rate conversion of audio data"
  homepage "http://www.mega-nerd.com/SRC"
  url "http://www.mega-nerd.com/SRC/libsamplerate-0.1.9.tar.gz"
  sha256 "0a7eb168e2f21353fb6d84da152e4512126f7dc48ccb0be80578c565413444c1"
  revision 1



  depends_on "pkg-config" => :build
  depends_on "libsndfile"

  # configure adds `/Developer/Headers/FlatCarbon` to the include, but this is
  # very deprecated. Correct the use of Carbon.h to the non-flat location.
  # See: https://github.com/Homebrew/homebrew/pull/10875
  patch :DATA

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end

__END__
--- a/examples/audio_out.c	2011-07-12 16:57:31.000000000 -0700
+++ b/examples/audio_out.c	2012-03-11 20:48:57.000000000 -0700
@@ -168,7 +168,7 @@
 
 #if (defined (__MACH__) && defined (__APPLE__)) /* MacOSX */
 
-#include <Carbon.h>
+#include <Carbon/Carbon.h>
 #include <CoreAudio/AudioHardware.h>
 
 #define	MACOSX_MAGIC	MAKE_MAGIC ('M', 'a', 'c', ' ', 'O', 'S', ' ', 'X')
