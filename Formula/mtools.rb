class Mtools < Formula
  desc "Tools for manipulating MSDOS files"
  homepage "https://www.gnu.org/software/mtools/"
  url "https://ftp.gnu.org/gnu/mtools/mtools-4.0.18.tar.gz"
  mirror "https://ftpmirror.gnu.org/mtools/mtools-4.0.18.tar.gz"
  sha256 "30d408d039b4cedcd04fbf824c89b0ff85dcbb6f71f13d2d8d65abb3f58cacc3"



  conflicts_with "multimarkdown", :because => "both install `mmd` binaries"

  def install
    # Prevents errors such as "mainloop.c:89:15: error: expected ')'"
    # Upstream issue https://lists.gnu.org/archive/html/info-mtools/2014-02/msg00000.html
    if ENV.cc == "clang"
      inreplace "sysincludes.h",
        "#  define UNUSED(x) x __attribute__ ((unused));x",
        "#  define UNUSED(x) x"
    end

    args = %W[
      LIBS=-liconv
      --disable-debug
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --without-x
    ]

    system "./configure", *args
    system "make"
    ENV.deparallelize
    system "make", "install"
  end

  test do
    assert_match /#{version}/, shell_output("#{bin}/mtools --version")
  end
end
