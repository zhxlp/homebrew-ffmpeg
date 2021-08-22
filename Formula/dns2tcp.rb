class Dns2tcp < Formula
  desc "TCP over DNS tunnel"
  homepage "https://packages.debian.org/sid/dns2tcp"
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/d/dns2tcp/dns2tcp_0.5.2.orig.tar.gz"
  mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/d/dns2tcp/dns2tcp_0.5.2.orig.tar.gz"
  sha256 "ea9ef59002b86519a43fca320982ae971e2df54cdc54cdb35562c751704278d9"



  def install
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make", "install"
  end

  test do
    assert_match(/^dns2tcp v#{version} /,
                 shell_output("#{bin}/dns2tcpc -help 2>&1", 255))
  end
end
