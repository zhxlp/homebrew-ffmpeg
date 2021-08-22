class MysqlConnectorC < Formula
  desc "MySQL database connector for C applications"
  homepage "https://dev.mysql.com/downloads/connector/c/"
  url "https://dev.mysql.com/get/Downloads/Connector-C/mysql-connector-c-6.1.11-src.tar.gz"
  sha256 "c8664851487200162b38b6f3c8db69850bd4f0e4c5ff5a6d161dbfb5cb76b6c4"



  depends_on "cmake" => :build
  depends_on "openssl"

  conflicts_with "mysql", "mariadb", "percona-server",
    :because => "both install MySQL client libraries"
  conflicts_with "mysql-cluster",
    :because => "both install `bin/my_print_defaults`"

  def install
    system "cmake", ".", "-DWITH_SSL=system", *std_cmake_args
    system "make", "install"
  end

  test do
    assert_match include.to_s, shell_output("#{bin}/mysql_config --cflags")
  end
end
