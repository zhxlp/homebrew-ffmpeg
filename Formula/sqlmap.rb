class Sqlmap < Formula
  desc "Penetration testing for SQL injection and database servers"
  homepage "http://sqlmap.org"
  url "https://github.com/sqlmapproject/sqlmap/archive/1.3.tar.gz"
  sha256 "7ea4684e01956e411960a5fd8a6d5b74b3f5972c2a3c6553fbd1e729819190ff"
  head "https://github.com/sqlmapproject/sqlmap.git"

  bottle :unneeded

  def install
    libexec.install Dir["*"]

    bin.install_symlink libexec/"sqlmap.py"
    bin.install_symlink bin/"sqlmap.py" => "sqlmap"

    bin.install_symlink libexec/"sqlmapapi.py"
    bin.install_symlink bin/"sqlmapapi.py" => "sqlmapapi"
  end

  test do
    data = %w[Bob 14 Sue 12 Tim 13]
    create = "create table students (name text, age integer);\n"
    data.each_slice(2) do |n, a|
      create << "insert into students (name, age) values ('#{n}', '#{a}');\n"
    end
    pipe_output("sqlite3 school.sqlite", create, 0)
    select = "select name, age from students order by age asc;"
    args = %W[--batch -d sqlite://school.sqlite --sql-query "#{select}"]
    output = shell_output("#{bin}/sqlmap #{args.join(" ")}")
    data.each_slice(2) { |n, a| assert_match "#{n}, #{a}", output }
  end
end
