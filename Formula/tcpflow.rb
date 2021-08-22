class Tcpflow < Formula
  desc "TCP flow recorder"
  homepage "https://github.com/simsong/tcpflow"
  url "https://digitalcorpora.org/downloads/tcpflow/tcpflow-1.5.0.tar.gz"
  sha256 "20abe3353a49a13dcde17ad318d839df6312aa6e958203ea710b37bede33d988"



  head do
    url "https://github.com/simsong/tcpflow.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "boost" => :build
  depends_on "openssl"

  def install
    system "bash", "./bootstrap.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end
end
