class Bc < Formula
  desc "Arbitrary precision numeric processing language"
  homepage "https://www.gnu.org/software/bc/"
  url "https://ftp.gnu.org/gnu/bc/bc-1.07.1.tar.gz"
  mirror "https://ftpmirror.gnu.org/bc/bc-1.07.1.tar.gz"
  sha256 "62adfca89b0a1c0164c2cdca59ca210c1d44c3ffc46daf9931cf4942664cb02a"



  keg_only :provided_by_macos

  def install
    # prevent user BC_ENV_ARGS from interfering with or influencing the
    # bootstrap phase of the build, particularly
    # BC_ENV_ARGS="--mathlib=./my_custom_stuff.b"
    ENV.delete("BC_ENV_ARGS")
    system "./configure",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--disable-silent-rules",
      "--prefix=#{prefix}",
      "--infodir=#{info}",
      "--mandir=#{man}",
      "--with-libedit"
    system "make", "install"
  end

  test do
    system "#{bin}/bc", "--version"
    assert_match "2", pipe_output("#{bin}/bc", "1+1\n")
  end
end
