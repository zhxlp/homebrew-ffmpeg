class Sshtrix < Formula
  desc "SSH login cracker"
  homepage "http://www.nullsecurity.net/tools/cracker.html"
  url "https://github.com/nullsecuritynet/tools/raw/master/cracker/sshtrix/release/sshtrix-0.0.2.tar.gz"
  sha256 "dc90a8b2fbb62689d1b59333413b56a370a0715c38bf0792f517ed6f9763f5df"
  revision 1



  depends_on "libssh"

  def install
    # https://github.com/nullsecuritynet/tools/issues/6
    inreplace "Makefile", "-lssh_threads", ""

    bin.mkpath
    system "make", "sshtrix", "CC=#{ENV.cc}"
    system "make", "DISTDIR=#{prefix}", "install"
  end

  test do
    system "#{bin}/sshtrix", "-V"
    system "#{bin}/sshtrix", "-O"
  end
end
