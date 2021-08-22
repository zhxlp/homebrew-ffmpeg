class Hyperestraier < Formula
  desc "Full-text search system for communities"
  homepage "https://fallabs.com/hyperestraier/"
  url "https://fallabs.com/hyperestraier/hyperestraier-1.4.13.tar.gz"
  sha256 "496f21190fa0e0d8c29da4fd22cf5a2ce0c4a1d0bd34ef70f9ec66ff5fbf63e2"



  depends_on "qdbm"

  def install
    system "./configure", "--disable-debug", "--prefix=#{prefix}",
                          "--disable-dependency-tracking"
    system "make", "mac"
    system "make", "check-mac"
    system "make", "install-mac"
  end

  test do
    system "#{bin}/estcmd", "version"
  end
end
