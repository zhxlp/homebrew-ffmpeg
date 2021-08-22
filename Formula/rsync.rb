class Rsync < Formula
  desc "Utility that provides fast incremental file transfer"
  homepage "https://rsync.samba.org/"
  url "https://rsync.samba.org/ftp/rsync/rsync-3.1.3.tar.gz"
  mirror "https://mirrors.kernel.org/gentoo/distfiles/rsync-3.1.3.tar.gz"
  mirror "https://www.mirrorservice.org/sites/rsync.samba.org/rsync-3.1.3.tar.gz"
  sha256 "55cc554efec5fdaad70de921cd5a5eeb6c29a95524c715f3bbf849235b0800c0"
  revision 1



  depends_on "autoconf" => :build

  # hfs-compression.diff is marked by upstream as broken as of 3.1.3
  patch do
    url "https://download.samba.org/pub/rsync/src/rsync-patches-3.1.3.tar.gz"
    mirror "https://www.mirrorservice.org/sites/rsync.samba.org/rsync-patches-3.1.3.tar.gz"
    mirror "https://launchpad.net/rsync/main/3.1.2/+download/rsync-patches-3.1.3.tar.gz"
    sha256 "0dc2848f20ca75c07a30c3237ccf8d61b61082ae7de94758a27dac350c99fb98"
    apply "patches/fileflags.diff",
          "patches/crtimes.diff"
  end

  # Fix "error: too few arguments to function call, expected 4, have 2"
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/344bf3b/rsync/fix-crtimes-patch-3.1.3.diff"
    sha256 "1a3c9043e19b55290bd6a6bc480544fe79a155c2c7ed003de185521f7516ecc3"
  end

  def install
    system "./prepare-source"
    system "./configure", "--disable-debug",
                          "--prefix=#{prefix}",
                          "--with-rsyncd-conf=#{etc}/rsyncd.conf",
                          "--enable-ipv6"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"rsync", "--version"
  end
end
