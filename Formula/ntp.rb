class Ntp < Formula
  desc "The Network Time Protocol (NTP) Distribution"
  homepage "https://www.eecis.udel.edu/~mills/ntp/html/"
  url "https://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2/ntp-4.2.8p12.tar.gz"
  version "4.2.8p12"
  sha256 "709b222b5013d77d26bfff532b5ea470a8039497ef29d09363931c036cb30454"



  depends_on "openssl"

  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --with-openssl-libdir=#{Formula["openssl"].lib}
      --with-openssl-incdir=#{Formula["openssl"].include}
      --with-net-snmp-config=no
    ]

    system "./configure", *args
    system "make", "install", "LDADD_LIBNTP=-lresolv -undefined dynamic_lookup"
  end

  test do
    assert_match "step time server ", shell_output("#{sbin}/ntpdate -bq pool.ntp.org")
  end
end
