class Gpsim < Formula
  desc "Simulator for Microchip's PIC microcontrollers"
  homepage "https://gpsim.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/gpsim/gpsim/0.30.0/gpsim-0.30.0.tar.gz"
  sha256 "e1927312c37119bc26d6abf2c250072a279a9c764c49ae9d71b4ccebb8154f86"
  head "https://svn.code.sf.net/p/gpsim/code/trunk"



  depends_on "gputils" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "popt"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-gui",
                          "--disable-shared",
                          "--prefix=#{prefix}"
    system "make", "all"
    system "make", "install"
  end

  test do
    system "#{bin}/gpsim", "--version"
  end
end
