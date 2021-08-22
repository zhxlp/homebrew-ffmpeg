class Libpcap < Formula
  desc "Portable library for network traffic capture"
  homepage "https://www.tcpdump.org/"
  url "https://www.tcpdump.org/release/libpcap-1.9.0.tar.gz"
  sha256 "2edb88808e5913fdaa8e9c1fcaf272e19b2485338742b5074b9fe44d68f37019"
  head "https://github.com/the-tcpdump-group/libpcap.git"



  keg_only :provided_by_macos

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--enable-ipv6",
                          "--disable-universal"
    system "make", "install"
  end

  test do
    assert_match /lpcap/, shell_output("#{bin}/pcap-config --libs")
  end
end
