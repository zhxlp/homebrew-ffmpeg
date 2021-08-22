class Cutter < Formula
  desc "Unit Testing Framework for C and C++"
  homepage "https://cutter.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/cutter/cutter/1.2.6/cutter-1.2.6.tar.gz"
  sha256 "459becce78ec4c568f4f5a5e20c73ea36be283bf955f4a252e8491b634339065"
  head "https://github.com/clear-code/cutter.git"



  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "glib"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--disable-glibtest",
                          "--disable-goffice",
                          "--disable-gstreamer",
                          "--disable-libsoup"
    system "make"
    system "make", "install"
  end

  test do
    touch "1.txt"
    touch "2.txt"
    system bin/"cut-diff", "1.txt", "2.txt"
  end
end
