class Dante < Formula
  desc "SOCKS server and client, implementing RFC 1928 and related standards"
  homepage "https://www.inet.no/dante/"
  url "https://www.inet.no/dante/files/dante-1.4.2.tar.gz"
  sha256 "4c97cff23e5c9b00ca1ec8a95ab22972813921d7fbf60fc453e3e06382fc38a7"



  def install
    system "./configure", "--disable-debug",
                          "--disable-silent-rules",
                          # Enabling dependency tracking disables universal
                          # build, avoiding a build error on Mojave
                          "--enable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}/dante"
    system "make", "install"
  end

  test do
    system "#{sbin}/sockd", "-v"
  end
end
