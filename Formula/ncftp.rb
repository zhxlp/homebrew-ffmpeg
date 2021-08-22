class Ncftp < Formula
  desc "FTP client with an advanced user interface"
  homepage "https://www.ncftp.com/"
  url "ftp://ftp.ncftp.com/ncftp/ncftp-3.2.6-src.tar.gz"
  mirror "https://fossies.org/linux/misc/ncftp-3.2.6-src.tar.gz"
  sha256 "129e5954850290da98af012559e6743de193de0012e972ff939df9b604f81c23"



  def install
    system "./configure", "--disable-universal",
                          "--disable-precomp",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/ncftp", "-F"
  end
end
