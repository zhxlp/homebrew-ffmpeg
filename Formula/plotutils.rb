class Plotutils < Formula
  desc "C/C++ function library for exporting 2-D vector graphics"
  homepage "https://www.gnu.org/software/plotutils/"
  url "https://ftp.gnu.org/gnu/plotutils/plotutils-2.6.tar.gz"
  mirror "https://ftpmirror.gnu.org/plotutils/plotutils-2.6.tar.gz"
  sha256 "4f4222820f97ca08c7ea707e4c53e5a3556af4d8f1ab51e0da6ff1627ff433ab"
  revision 1



  depends_on "libpng"

  def install
    # Fix usage of libpng to be 1.5 compatible
    inreplace "libplot/z_write.c", "png_ptr->jmpbuf", "png_jmpbuf (png_ptr)"

    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --enable-libplotter
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    assert pipe_output("#{bin}/graph -T ps", "0.0 0.0\n1.0 0.2\n").start_with?("")
  end
end
