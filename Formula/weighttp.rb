class Weighttp < Formula
  desc "Webserver benchmarking tool that supports multithreading"
  homepage "https://redmine.lighttpd.net/projects/weighttp/wiki"
  url "https://github.com/lighttpd/weighttp/archive/weighttp-0.4.tar.gz"
  sha256 "b4954f2a1eca118260ffd503a8e3504dd32942e2e61d0fa18ccb6b8166594447"
  head "https://git.lighttpd.net/weighttp.git"



  depends_on "libev"

  def install
    system "./waf", "configure"
    system "./waf", "build"
    bin.install "build/default/weighttp"
  end

  test do
    # Stick with HTTP to avoid 'error: no ssl support yet'
    system "#{bin}/weighttp", "-n", "1", "http://redmine.lighttpd.net/projects/weighttp/wiki"
  end
end
