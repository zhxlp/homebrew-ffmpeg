class Ocproxy < Formula
  desc "User-level SOCKS and port forwarding proxy"
  homepage "https://github.com/cernekee/ocproxy"
  url "https://github.com/cernekee/ocproxy/archive/v1.60.tar.gz"
  sha256 "a7367647f07df33869e2f79da66b6f104f6495ae806b12a8b8d9ca82fb7899ac"
  head "https://github.com/cernekee/ocproxy.git"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libevent"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match /VPNFD.is.not.set/, shell_output("#{bin}/ocproxy 2>&1", 1)
  end
end
