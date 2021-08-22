class Alpine < Formula
  desc "News and email agent"
  homepage "https://repo.or.cz/alpine.git"
  url "https://ftp.osuosl.org/pub/blfs/conglomeration/alpine/alpine-2.21.tar.xz"
  mirror "https://fossies.org/linux/misc/alpine-2.21.tar.xz"
  sha256 "6030b6881b8168546756ab3a5e43628d8d564539b0476578e287775573a77438"



  depends_on "openssl"

  def install
    ENV.deparallelize

    args = %W[
      --disable-debug
      --with-ssl-dir=#{Formula["openssl"].opt_prefix}
      --with-ssl-certs-dir=#{etc}/openssl
      --prefix=#{prefix}
      --with-passfile=.pine-passfile
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/alpine", "-supported"
  end
end
