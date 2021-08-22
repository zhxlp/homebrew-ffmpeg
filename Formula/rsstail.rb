class Rsstail < Formula
  desc "Monitors an RSS feed and emits new entries when detected"
  homepage "https://www.vanheusden.com/rsstail/"
  url "https://www.vanheusden.com/rsstail/rsstail-2.1.tgz"
  sha256 "42cb452178b21c15c470bafbe5b8b5339a7fb5b980bf8d93d36af89864776e71"
  head "https://github.com/flok99/rsstail.git"



  depends_on "libmrss"

  resource "libiconv_hook" do
    url "https://www.mirrorservice.org/sites/archive.ubuntu.com/ubuntu/pool/universe/liba/libapache-mod-encoding/libapache-mod-encoding_0.0.20021209.orig.tar.gz"
    sha256 "1319b3cffd60982f0c739be18f816be77e3af46cd9039ac54417c1219518cf89"
  end

  def install
    (buildpath/"libiconv_hook").install resource("libiconv_hook")
    cd "libiconv_hook/lib" do
      system "./configure", "--disable-shared"
      system "make"
    end

    system "make", "LDFLAGS=-liconv -liconv_hook -lmrss -L#{buildpath}/libiconv_hook/lib/.libs"
    man1.install "rsstail.1"
    bin.install "rsstail"
  end

  test do
    assert_match(/^Title: /,
                 shell_output("#{bin}/rsstail -1u https://developer.apple.com/news/rss/news.rss"))
  end
end
