class SqlTranslator < Formula
  desc "Manipulate structured data definitions (SQL and more)"
  homepage "https://github.com/dbsrgits/sql-translator/"
  url "https://cpan.metacpan.org/authors/id/I/IL/ILMARI/SQL-Translator-0.11024.tar.gz"
  sha256 "5bde9d6f67850089ef35a9296d6f53e5ee8e991438366b71477f3f27c1581bb1"



  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV["PERL_MM_OPT"] = "INSTALL_BASE=#{libexec}"

    system "perl", "Makefile.PL", "--defaultdeps"
    system "make", "install"

    bin.install Dir["#{libexec}/bin/sqlt*"]
    man1.install Dir["#{libexec}/man/man1/sqlt*.1"]
    bin.env_script_all_files libexec/"bin", :PERL5LIB => ENV["PERL5LIB"]
  end

  test do
    command = "#{bin}/sqlt -f MySQL -t PostgreSQL --no-comments -"
    sql_input = "create table sqlt ( id int AUTO_INCREMENT );"
    sql_output = <<~EOS
      CREATE TABLE "sqlt" (
        "id" serial
      );

    EOS
    assert_equal sql_output, pipe_output(command, sql_input)
  end
end
