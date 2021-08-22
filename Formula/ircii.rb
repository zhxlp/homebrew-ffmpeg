class Ircii < Formula
  desc "IRC and ICB client"
  homepage "http://www.eterna.com.au/ircii/"
  url "https://ircii.warped.com/ircii-20170704.tar.bz2"
  mirror "https://mirrors.ocf.berkeley.edu/debian/pool/main/i/ircii/ircii_20170704.orig.tar.bz2"
  sha256 "4e5a70fc4577de06fd5855ab7ca0a501fd16e02d5fd34e434a2b5abac80a2eda"



  depends_on "openssl"

  def install
    ENV.append "LIBS", "-liconv"
    system "./configure", "--prefix=#{prefix}",
                          "--with-default-server=irc.freenode.net",
                          "--enable-ipv6"
    system "make"
    ENV.deparallelize
    system "make", "install"
  end

  test do
    IO.popen("#{bin}/irc -d", "r+") do |pipe|
      assert_match "Connecting to port 6667 of server irc.freenode.net", pipe.gets
      pipe.puts "/quit"
      pipe.close_write
      pipe.close
    end
  end
end
