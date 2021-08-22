class Udptunnel < Formula
  desc "Tunnel UDP packets over a TCP connection"
  homepage "https://web.archive.org/web/20161224191851/www.cs.columbia.edu/~lennox/udptunnel/"
  url "https://web.archive.org/web/20161224191851/www.cs.columbia.edu/~lennox/udptunnel/udptunnel-1.1.tar.gz"
  mirror "https://ftp.nsysu.edu.tw/FreeBSD/ports/local-distfiles/leeym/udptunnel-1.1.tar.gz"
  sha256 "45c0e12045735bc55734076ebbdc7622c746d1fe4e6f7267fa122e2421754670"



  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
    doc.install "udptunnel.html"
  end

  test do
    system "#{bin}/udptunnel -h; true"
  end
end
