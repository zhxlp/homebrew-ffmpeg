class Ephemeralpg < Formula
  desc "Run tests on an isolated, temporary Postgres database"
  homepage "http://ephemeralpg.org"
  url "http://ephemeralpg.org/code/ephemeralpg-2.5.tar.gz"
  mirror "https://bitbucket.org/eradman/ephemeralpg/get/ephemeralpg-2.5.tar.gz"
  sha256 "93a350443e431f474c4f898fe8bbe649e20957b25ce1d9d43810117128658e00"



  depends_on "postgresql"

  def install
    system "make", "PREFIX=#{prefix}", "MANPREFIX=#{man}", "install"
  end

  test do
    system "#{bin}/pg_tmp", "selftest"
  end
end
