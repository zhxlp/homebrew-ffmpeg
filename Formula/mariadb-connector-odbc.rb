class MariadbConnectorOdbc < Formula
  desc "Database driver using the industry standard ODBC API"
  homepage "https://downloads.mariadb.org/connector-odbc/"
  url "https://downloads.mariadb.org/f/connector-odbc-3.0.2/mariadb-connector-odbc-3.0.2-ga-src.tar.gz"
  sha256 "eba4fbda21ae9d50c94d2cd152f0ec14dde3989522f41ef7d22aa0948882ff93"



  depends_on "cmake" => :build
  depends_on "mariadb-connector-c"
  depends_on "openssl"
  depends_on "unixodbc"

  def install
    system "cmake", ".", "-DMARIADB_FOUND=1",
                         "-DWITH_OPENSSL=1",
                         "-DOPENSSL_INCLUDE_DIR=#{Formula["openssl"].opt_include}",
                         *std_cmake_args
    system "make", "install"
  end

  test do
    output = shell_output("#{Formula["unixodbc"].opt_bin}/dltest #{lib}/libmaodbc.dylib")
    assert_equal "SUCCESS: Loaded #{lib}/libmaodbc.dylib", output.chomp
  end
end
