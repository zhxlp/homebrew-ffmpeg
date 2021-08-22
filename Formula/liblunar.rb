class Liblunar < Formula
  desc "Lunar date calendar"
  homepage "https://code.google.com/archive/p/liblunar/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/liblunar/liblunar-2.2.5.tar.gz"
  sha256 "c24a7cd3ccbf7ab739d752a437f1879f62b975b95abcf9eb9e1dd623982bc167"



  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "glib"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
