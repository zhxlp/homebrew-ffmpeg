class Ncrack < Formula
  desc "Network authentication cracking tool"
  homepage "https://nmap.org/ncrack/"
  url "https://github.com/nmap/ncrack/archive/v0.6.0.tar.gz"
  sha256 "676a323b1e9066193461f25e31445262bae495fde7dfcaf56555c3056dae24cc"
  head "https://github.com/nmap/ncrack.git"



  depends_on "openssl"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    assert_match version.to_f.to_s, shell_output(bin/"ncrack --version")
  end
end
