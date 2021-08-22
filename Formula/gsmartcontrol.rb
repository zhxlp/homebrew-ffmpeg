class Gsmartcontrol < Formula
  desc "Graphical user interface for smartctl"
  homepage "https://gsmartcontrol.sourceforge.io"
  url "https://downloads.sourceforge.net/project/gsmartcontrol/1.1.3/gsmartcontrol-1.1.3.tar.bz2"
  sha256 "b64f62cffa4430a90b6d06cd52ebadd5bcf39d548df581e67dfb275a673b12a9"
  revision 1



  depends_on "pkg-config" => :build
  depends_on "gtkmm3"
  depends_on "pcre"
  depends_on "smartmontools"

  def install
    ENV.cxx11
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{sbin}/gsmartcontrol", "--version"
  end
end
