class Gsasl < Formula
  desc "SASL library command-line interface"
  homepage "https://www.gnu.org/software/gsasl/"
  url "https://ftp.gnu.org/gnu/gsasl/gsasl-1.8.0.tar.gz"
  mirror "https://ftpmirror.gnu.org/gsasl/gsasl-1.8.0.tar.gz"
  sha256 "310262d1ded082d1ceefc52d6dad265c1decae8d84e12b5947d9b1dd193191e5"



  def install
    system "./configure", "--disable-dependency-tracking",
                          "--with-gssapi-impl=mit",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match /#{version}/, shell_output("#{bin}/gsasl")
  end
end
