class SstpClient < Formula
  desc "SSTP (Microsofts Remote Access Solution for PPP over SSL) client"
  homepage "https://sstp-client.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/sstp-client/sstp-client/sstp-client-1.0.12.tar.gz"
  sha256 "487eb406579689803ce0397f6102b18641e4572ac7bc9b9e5f3027c84dcf67ff"



  depends_on "pkg-config" => :build
  depends_on "libevent"
  depends_on "openssl"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--disable-ppp-plugin",
                          "--prefix=#{prefix}",
                          "--with-runtime-dir=#{var}/run/sstpc"
    system "make", "install"

    # Create a directory needed by sstpc for privilege separation
    (var/"run/sstpc").mkpath
  end

  def caveats; <<~EOS
    sstpc reads PPP configuration options from /etc/ppp/options. If this file
    does not exist yet, type the following command to create it:

    sudo touch /etc/ppp/options
  EOS
  end

  test do
    system "#{sbin}/sstpc", "--version"
  end
end
