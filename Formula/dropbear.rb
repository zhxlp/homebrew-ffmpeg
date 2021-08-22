class Dropbear < Formula
  desc "Small SSH server/client for POSIX-based system"
  homepage "https://matt.ucc.asn.au/dropbear/dropbear.html"
  revision 1

  stable do
    url "https://matt.ucc.asn.au/dropbear/releases/dropbear-2018.76.tar.bz2"
    sha256 "f2fb9167eca8cf93456a5fc1d4faf709902a3ab70dd44e352f3acbc3ffdaea65"

    # Fixes CVE-2018-15599. Safe to remove on next release.
    # https://lists.ucc.gu.uwa.edu.au/pipermail/dropbear/2018q3/002108.html
    patch do
      url "https://secure.ucc.asn.au/hg/dropbear/raw-rev/5d2d1021ca00"
      sha256 "42b5720cf6c888638cfb84fdd862fc0d323b2e023cbe5f9ccdaa2e0c35b6873e"
    end
  end



  head do
    url "https://github.com/mkj/dropbear.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  def install
    ENV.deparallelize

    if build.head?
      system "autoconf"
      system "autoheader"
    end
    system "./configure", "--prefix=#{prefix}",
                          "--enable-pam",
                          "--enable-zlib",
                          "--enable-bundled-libtom",
                          "--sysconfdir=#{etc}/dropbear"
    system "make"
    system "make", "install"
  end

  test do
    testfile = testpath/"testec521"
    system "#{bin}/dbclient", "-h"
    system "#{bin}/dropbearkey", "-t", "ecdsa", "-f", testfile, "-s", "521"
    assert_predicate testfile, :exist?
  end
end
