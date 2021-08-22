class Sipp < Formula
  desc "Traffic generator for the SIP protocol"
  homepage "https://sipp.sourceforge.io/"
  url "https://github.com/SIPp/sipp/releases/download/v3.5.2/sipp-3.5.2.tar.gz"
  sha256 "875fc2dc2e46064aa8af576a26166b45e8a0ae22ec2ae0481baf197931c59609"



  def install
    system "./configure", "--with-pcap"
    system "make", "DESTDIR=#{prefix}"
    bin.install "sipp"
  end

  test do
    assert_match "SIPp v#{version}", shell_output("#{bin}/sipp -v", 99)
  end
end
