class Libexosip < Formula
  desc "Toolkit for eXosip2"
  homepage "https://www.antisip.com/category/osip-and-exosip-toolkit"
  url "https://download.savannah.gnu.org/releases/exosip/libeXosip2-4.1.0.tar.gz"
  sha256 "3c77713b783f239e3bdda0cc96816a544c41b2c96fa740a20ed322762752969d"
  revision 1



  depends_on "pkg-config" => :build
  depends_on "libosip"
  depends_on "openssl"

  def install
    # Extra linker flags are needed to build this on macOS. See:
    # https://growingshoot.blogspot.com/2013/02/manually-install-osip-and-exosip-as.html
    # Upstream bug ticket: https://savannah.nongnu.org/bugs/index.php?45079
    ENV.append "LDFLAGS", "-framework CoreFoundation -framework CoreServices "\
                          "-framework Security"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
