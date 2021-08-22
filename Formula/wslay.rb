class Wslay < Formula
  desc "C websocket library"
  homepage "https://wslay.sourceforge.io/"
  url "https://github.com/tatsuhiro-t/wslay/releases/download/release-1.1.0/wslay-1.1.0.tar.xz"
  sha256 "0d82d247b847cc08e798ee2f28ee22b331d54e5900b3e1bef184945770185e17"



  head do
    url "https://github.com/tatsuhiro-t/wslay.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "cunit" => :build
  depends_on "pkg-config" => :build
  depends_on "sphinx-doc" => :build

  def install
    system "autoreconf", "-fvi" if build.head?
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules"
    system "make", "check"
    system "make", "install"
  end
end
