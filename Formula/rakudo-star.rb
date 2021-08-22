class RakudoStar < Formula
  desc "Perl 6 compiler"
  homepage "https://rakudo.org/"
  url "https://rakudo.perl6.org/downloads/star/rakudo-star-2018.10.tar.gz"
  sha256 "a4914220b58de6b3298adfc80d740a1fb69dbb1fed6155e563eb0a9d4b63a346"



  depends_on "gmp"
  depends_on "icu4c"
  depends_on "libffi"
  depends_on "pcre"

  conflicts_with "parrot"

  def install
    libffi = Formula["libffi"]
    ENV.remove "CPPFLAGS", "-I#{libffi.include}"
    ENV.prepend "CPPFLAGS", "-I#{libffi.lib}/libffi-#{libffi.version}/include"

    ENV.deparallelize # An intermittent race condition causes random build failures.

    system "perl", "Configure.pl", "--prefix=#{prefix}",
                   "--backends=moar", "--gen-moar"
    system "make"
    # make install runs tests that can hang on sierra
    # set this variable to skip those tests
    ENV["NO_NETWORK_TESTING"] = "1"
    system "make", "install"

    # Panda is now in share/perl6/site/bin, so we need to symlink it too.
    bin.install_symlink Dir[share/"perl6/site/bin/*"]

    # Move the man pages out of the top level into share.
    # Not all backends seem to generate man pages at this point (moar does not, parrot does),
    # so we need to check if the directory exists first.
    mv "#{prefix}/man", share if File.directory?("#{prefix}/man")
  end

  test do
    out = `#{bin}/perl6 -e 'loop (my $i = 0; $i < 10; $i++) { print $i }'`
    assert_equal "0123456789", out
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
