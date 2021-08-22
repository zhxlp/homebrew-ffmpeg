class Gdnsd < Formula
  desc "Authoritative-only DNS server"
  homepage "https://gdnsd.org/"
  url "https://github.com/gdnsd/gdnsd/releases/download/v2.4.0/gdnsd-2.4.0.tar.xz"
  sha256 "3d56ccbb27054dc155839d94df136d760ac361abe868aa6a8c3dbfc9e464bb99"



  head do
    url "https://github.com/gdnsd/gdnsd.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "libev"
  depends_on "libunwind-headers"
  depends_on "ragel"

  def install
    system "autoreconf", "-fvi" if build.head?
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-rundir=#{var}/run",
                          "--localstatedir=#{var}",
                          "--sysconfdir=#{etc}",
                          "--without-urcu"
    system "make", "install"
  end

  test do
    (testpath/"config").write("options => { listen => [ 127.0.0.1 ] }")
    system "#{sbin}/gdnsd", "-c", testpath, "checkconf"
  end
end
