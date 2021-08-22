class Sproxy < Formula
  desc "HTTP proxy server collecting URLs in a 'siege-friendly' manner"
  homepage "https://www.joedog.org/sproxy-home/"
  url "http://download.joedog.org/sproxy/sproxy-1.02.tar.gz"
  sha256 "29b84ba66112382c948dc8c498a441e5e6d07d2cd5ed3077e388da3525526b72"



  # Only needed due to the change to "Makefile.am"
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    # Prevents "ERROR: Can't create '/usr/local/share/man/man3'"; also fixes an
    # audit violation triggered if the man page is installed in #{prefix}/man.
    # After making the change below and running autoreconf, the default ends up
    # being the same as #{man}, so there's no need for us to pass --mandir to
    # configure, though, as a result of this change, that flag would be honored.
    # Reported 10th May 2016 to https://www.joedog.org/support/
    inreplace "doc/Makefile.am", "$(prefix)/man", "$(mandir)"
    inreplace "lib/Makefile.am", "Makefile.PL", "Makefile.PL PREFIX=$(prefix)"

    # Only needed due to the change to "Makefile.am"
    system "autoreconf", "-fiv"

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    assert_match "SPROXY v#{version}-", shell_output("#{bin}/sproxy -V")
  end
end
