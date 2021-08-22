class Giflib < Formula
  desc "Library and utilities for processing GIFs"
  homepage "https://giflib.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/giflib/giflib-5.1.4.tar.bz2"
  sha256 "df27ec3ff24671f80b29e6ab1c4971059c14ac3db95406884fc26574631ba8d5"
  revision 1



  # CVE-2016-3977
  # https://sourceforge.net/p/giflib/bugs/102/
  # https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=820526
  patch do
    url "https://mirrors.ocf.berkeley.edu/debian/pool/main/g/giflib/giflib_5.1.4-3.debian.tar.xz"
    mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/g/giflib/giflib_5.1.4-3.debian.tar.xz"
    sha256 "767ea03c1948fa203626107ead3d8b08687a3478d6fbe4690986d545fb1d60bf"
    apply "patches/CVE-2016-3977.patch"
  end

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/giftext #{test_fixtures("test.gif")}")
    assert_match "Screen Size - Width = 1, Height = 1", output
  end
end
