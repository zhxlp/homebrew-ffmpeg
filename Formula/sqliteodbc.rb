class Sqliteodbc < Formula
  desc "SQLite ODBC driver"
  homepage "https://ch-werner.homepage.t-online.de/sqliteodbc/"
  url "https://ch-werner.homepage.t-online.de/sqliteodbc/sqliteodbc-0.9996.tar.gz"
  sha256 "8afbc9e0826d4ff07257d7881108206ce31b5f719762cbdb4f68201b60b0cb4e"



  depends_on "sqlite"
  depends_on "unixodbc"

  def install
    ENV["SDKROOT"] = MacOS.sdk_path if MacOS.version == :sierra

    lib.mkdir
    system "./configure", "--prefix=#{prefix}", "--with-odbc=#{Formula["unixodbc"].opt_prefix}", "--with-sqlite3=#{Formula["sqlite"].opt_prefix}"
    system "make"
    system "make", "install"
    lib.install_symlink "#{lib}/libsqlite3odbc.dylib" => "libsqlite3odbc.so"
  end

  test do
    output = shell_output("#{Formula["unixodbc"].opt_bin}/dltest #{lib}/libsqlite3odbc.so")
    assert_equal "SUCCESS: Loaded #{lib}/libsqlite3odbc.so\n", output
  end
end
