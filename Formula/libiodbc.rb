class Libiodbc < Formula
  desc "Database connectivity layer based on ODBC. (alternative to unixodbc)"
  homepage "http://www.iodbc.org/dataspace/iodbc/wiki/iODBC/"
  url "https://downloads.sourceforge.net/project/iodbc/iodbc/3.52.12/libiodbc-3.52.12.tar.gz"
  sha256 "51c5ff3a7d9a54202486cb77a3514e0e379a135beefcd5d12b96d1901f9dfb62"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"iodbc-config", "--version"
  end
end
