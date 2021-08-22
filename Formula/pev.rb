class Pev < Formula
  desc "PE analysis toolkit"
  homepage "https://pev.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/pev/pev-0.80/pev-0.80.tar.gz"
  sha256 "f68c8596f16d221d9a742812f6f728bcc739be90957bc1b00fbaa5943ffc5cfa"
  head "https://github.com/merces/pev.git"



  depends_on "openssl"
  depends_on "pcre"

  def install
    ENV.deparallelize
    system "make", "prefix=#{prefix}", "CC=#{ENV.cc}"
    system "make", "prefix=#{prefix}", "install"
  end

  test do
    system "#{bin}/pedis", "--version"
  end
end
