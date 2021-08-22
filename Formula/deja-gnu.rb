class DejaGnu < Formula
  desc "Framework for testing other programs"
  homepage "https://www.gnu.org/software/dejagnu/"
  url "https://ftp.gnu.org/gnu/dejagnu/dejagnu-1.6.1.tar.gz"
  mirror "https://ftpmirror.gnu.org/dejagnu/dejagnu-1.6.1.tar.gz"
  sha256 "bf5b28bb797e0ace4cfc0766a996339c795d8223bef54158be7887046bc01692"



  head do
    url "https://git.savannah.gnu.org/git/dejagnu.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  def install
    ENV.deparallelize # Or fails on Mac Pro
    system "autoreconf", "-iv" if build.head?
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    # DejaGnu has no compiled code, so go directly to "make check"
    system "make", "check"
    system "make", "install"
  end

  test do
    system "#{bin}/runtest"
  end
end
