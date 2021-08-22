class Paps < Formula
  desc "Pango to PostScript converter"
  homepage "https://github.com/dov/paps"
  url "https://github.com/dov/paps/archive/0.7.0.tar.gz"
  sha256 "7a18e8096944a21e0d9fcfb389770d1e7672ba90569180cb5d45984914cedb13"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "gettext"
  depends_on "glib"
  depends_on "pango"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
    pkgshare.install "examples"
  end

  test do
    system bin/"paps", pkgshare/"examples/small-hello.utf8", "-o", "paps.ps"
    assert_predicate testpath/"paps.ps", :exist?
    assert_match "Ch\\340o", (testpath/"paps.ps").read
  end
end
