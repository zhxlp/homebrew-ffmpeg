class Mpdas < Formula
  desc "C++ client to submit tracks to audioscrobbler"
  homepage "https://www.50hz.ws/mpdas/"
  url "https://www.50hz.ws/mpdas/mpdas-0.4.5.tar.gz"
  sha256 "c9103d7b897e76cd11a669e1c062d74cb73574efc7ba87de3b04304464e8a9ca"
  head "https://github.com/hrkfdn/mpdas.git"



  depends_on "pkg-config" => :build
  depends_on "libmpdclient"

  def install
    system "make", "PREFIX=#{prefix}", "MANPREFIX=#{man1}", "CONFIG=#{etc}", "install"
    etc.install "mpdasrc.example"
  end

  test do
    system bin/"mpdas", "-v"
  end
end
