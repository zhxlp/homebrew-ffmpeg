class Gloox < Formula
  desc "C++ Jabber/XMPP library that handles the low-level protocol"
  homepage "https://camaya.net/gloox/"
  url "https://camaya.net/download/gloox-1.0.21.tar.bz2"
  sha256 "3c13155c10e3182a1a57779134cc524efb3657545849534b2831fae0e2c3a7cc"
  revision 1



  depends_on "pkg-config" => :build
  depends_on "libidn"
  depends_on "openssl"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--with-zlib",
                          "--disable-debug",
                          "--with-openssl=#{Formula["openssl"].opt_prefix}"
    system "make", "install"
  end

  test do
    system bin/"gloox-config", "--cflags", "--libs", "--version"
  end
end
