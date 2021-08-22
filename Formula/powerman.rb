class Powerman < Formula
  desc "Control (remotely and in parallel) switched power distribution units"
  homepage "https://code.google.com/p/powerman/"
  url "https://github.com/chaos/powerman/releases/download/2.3.24/powerman-2.3.24.tar.gz"
  sha256 "85d5d0e0aef05a1637a8efe58f436f1548d2411c98c90c1616d22ee79c19d275"



  head do
    url "https://github.com/chaos/powerman.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "curl"

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--localstatedir=#{var}",
                          "--with-httppower",
                          "--with-ncurses",
                          "--without-genders",
                          "--without-snmppower",
                          "--without-tcp-wrappers"
    system "make", "install"
  end

  test do
    system "#{sbin}/powermand", "-h"
  end
end
