class CheckPostgres < Formula
  desc "Monitor Postgres databases"
  homepage "https://bucardo.org/wiki/Check_postgres"
  url "https://bucardo.org/downloads/check_postgres-2.23.0.tar.gz"
  sha256 "93cdbe92bb451525219b131a6810d9da0525000f6795160f70751b105c858615"
  head "https://github.com/bucardo/check_postgres.git"



  depends_on "postgresql"

  def install
    system "perl", "Makefile.PL", "PREFIX=#{prefix}"
    system "make", "install"
    mv bin/"check_postgres.pl", bin/"check_postgres"
    inreplace [bin/"check_postgres", man1/"check_postgres.1p"], "check_postgres.pl", "check_postgres"
    rm_rf prefix/"Library"
    rm_rf prefix/"lib"
  end

  test do
    # This test verifies that check_postgres fails correctly, assuming
    # that no server is running at that port.
    output = shell_output("#{bin}/check_postgres --action=connection --port=65432", 2)
    assert_match /POSTGRES_CONNECTION CRITICAL/, output
  end
end
