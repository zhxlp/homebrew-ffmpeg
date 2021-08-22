class Libstatgrab < Formula
  desc "Provides cross-platform access to statistics about the system"
  homepage "https://www.i-scream.org/libstatgrab/"
  url "https://ftp.i-scream.org/pub/i-scream/libstatgrab/libstatgrab-0.91.tar.gz"
  mirror "https://www.mirrorservice.org/pub/i-scream/libstatgrab/libstatgrab-0.91.tar.gz"
  sha256 "03e9328e4857c2c9dcc1b0347724ae4cd741a72ee11acc991784e8ef45b7f1ab"



  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/statgrab"
  end
end
