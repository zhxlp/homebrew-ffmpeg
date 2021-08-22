class GuileAT20 < Formula
  desc "GNU Ubiquitous Intelligent Language for Extensions"
  homepage "https://www.gnu.org/software/guile/"
  url "https://ftp.gnu.org/gnu/guile/guile-2.0.14.tar.xz"
  mirror "https://ftpmirror.gnu.org/guile/guile-2.0.14.tar.xz"
  sha256 "e8442566256e1be14e51fc18839cd799b966bc5b16c6a1d7a7c35155a8619d82"
  revision 3



  keg_only :versioned_formula

  depends_on "bdw-gc"
  depends_on "gmp"
  depends_on "libffi"
  depends_on "libtool"
  depends_on "libunistring"
  depends_on "pkg-config" # guile-config is a wrapper around pkg-config.
  depends_on "readline"

  if MacOS.version >= :sierra
    # https://debbugs.gnu.org/cgi/bugreport.cgi?bug=23870
    # https://git.net/ml/bug-guile-gnu/2016-06/msg00180.html
    # https://github.com/Homebrew/homebrew-core/issues/1957#issuecomment-229347476
    # https://gist.githubusercontent.com/rahulg/baa500e84136f0965e9ade2fb36b90ba/raw/4f1081838972ac9621fc68bb571daaf99fc0c045/libguile-stime-sierra.patch
    patch :p0 do
      url "https://raw.githubusercontent.com/macports/macports-ports/5a3bba7/lang/guile/files/sierra.patch"
      sha256 "6947f15e1aa6129f12eb692253bcc1ff969862f804de1f4d6360ad4786ae53f0"
    end

    # Filter incompat. mkostemp(3) flags on macOS 10.12
    # https://trac.macports.org/ticket/52613
    # https://debbugs.gnu.org/cgi/bugreport.cgi?bug=24862
    patch :p0 do
      url "https://raw.githubusercontent.com/macports/macports-ports/8b7f401/lang/guile/files/sierra-filter-incompatible-mkostemp-flags.patch"
      sha256 "90750429d92a2ea97c828435645a2fd3b399e1b571ced41ff1988894155b4934"
    end
  end

  def install
    system "./autogen.sh" unless build.stable?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-libreadline-prefix=#{Formula["readline"].opt_prefix}",
                          "--with-libgmp-prefix=#{Formula["gmp"].opt_prefix}"
    system "make", "install"

    # A really messed up workaround required on macOS --mkhl
    Pathname.glob("#{lib}/*.dylib") do |dylib|
      lib.install_symlink dylib.basename => "#{dylib.basename(".dylib")}.so"
    end

    (share/"gdb/auto-load").install Dir["#{lib}/*-gdb.scm"]
  end

  test do
    hello = testpath/"hello.scm"
    hello.write <<~EOS
      (display "Hello World")
      (newline)
    EOS

    ENV["GUILE_AUTO_COMPILE"] = "0"

    system bin/"guile", hello
  end
end
