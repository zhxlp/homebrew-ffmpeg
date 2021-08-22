class SwiProlog < Formula
  desc "ISO/Edinburgh-style Prolog interpreter"
  homepage "http://www.swi-prolog.org/"
  url "http://www.swi-prolog.org/download/stable/src/swipl-7.6.4.tar.gz"
  sha256 "2d3d7aabd6d99a02dcc2da5d7604e3500329e541c6f857edc5aa06a3b1267891"
  revision 1



  head do
    url "https://github.com/SWI-Prolog/swipl-devel.git"

    depends_on "cmake" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "gmp"
  depends_on "libarchive"
  depends_on "openssl"
  depends_on "readline"

  def install
    if build.head?
      mkdir "build" do
        system "cmake", "..", *std_cmake_args,
                        "-DSWIPL_PACKAGES_JAVA=OFF",
                        "-DSWIPL_PACKAGES_JAVA=OFF",
                        "-DSWIPL_PACKAGES_X=OFF",
                        "-DCMAKE_INSTALL_PREFIX=#{libexec}"
        system "make", "install"
      end
    else
      ENV["ARPREFIX"] = Formula["libarchive"].opt_prefix
      ENV.append "DISABLE_PKGS", "jpl"
      ENV.append "DISABLE_PKGS", "xpce"

      # SWI-Prolog's Makefiles don't add CPPFLAGS to the compile command, but do
      # include CIFLAGS. Setting it here. Also, they clobber CFLAGS, so including
      # the Homebrew-generated CFLAGS into COFLAGS here.
      ENV["CIFLAGS"] = ENV.cppflags
      ENV["COFLAGS"] = ENV.cflags

      system "./configure", "--prefix=#{libexec}", "--mandir=#{man}"
      system "make"
      system "make", "install"
    end

    bin.write_exec_script Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"test.pl").write <<~EOS
      test :-
          write('Homebrew').
    EOS
    assert_equal "Homebrew", shell_output("#{bin}/swipl -s #{testpath}/test.pl -g test -t halt")
  end
end
