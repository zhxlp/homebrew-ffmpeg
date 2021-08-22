class Frei0r < Formula
  desc "Minimalistic plugin API for video effects"
  homepage "https://frei0r.dyne.org/"
  url "https://files.dyne.org/frei0r/releases/frei0r-plugins-1.6.1.tar.gz"
  sha256 "e0c24630961195d9bd65aa8d43732469e8248e8918faa942cfb881769d11515e"



  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
