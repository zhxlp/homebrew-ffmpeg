class Libiscsi < Formula
  desc "Client library and utilities for iscsi"
  homepage "https://github.com/sahlberg/libiscsi"
  url "https://sites.google.com/site/libiscsitarballs/libiscsitarballs/libiscsi-1.18.0.tar.gz"
  sha256 "367ad1514d1640e4e72ca6754275ec226650a128ca108f61a86d766c94d63d23"
  revision 1
  head "https://github.com/sahlberg/libiscsi.git"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "cunit"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"iscsi-ls", "--usage"
    system bin/"iscsi-test-cu", "--list"
  end
end
