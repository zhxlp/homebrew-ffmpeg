class FreetdsAT091 < Formula
  desc "Libraries to talk to Microsoft SQL Server & Sybase"
  homepage "http://www.freetds.org/"
  url "http://www.freetds.org/files/stable/freetds-0.91.112.tar.gz"
  sha256 "be4f04ee57328c32e7e7cd7e2e1483e535071cec6101e46b9dd15b857c5078ed"
  revision 1



  keg_only :versioned_formula

  depends_on "pkg-config" => :build
  depends_on "openssl"
  depends_on "unixodbc"

  def install
    args = %W[
      --prefix=#{prefix}
      --mandir=#{man}
      --enable-krb5
      --with-openssl=#{Formula["openssl"].opt_prefix}
      --with-tdsver=7.1
      --with-unixodbc=#{Formula["unixodbc"].opt_prefix}
    ]

    system "./configure", *args
    system "make"
    ENV.deparallelize # Or fails to install on multi-core machines
    system "make", "install"
  end

  test do
    system "#{bin}/tsql", "-C"
  end
end
