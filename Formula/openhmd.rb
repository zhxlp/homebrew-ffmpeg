class Openhmd < Formula
  desc "Free and open source API and drivers for immersive technology"
  homepage "http://openhmd.net"
  url "https://github.com/OpenHMD/OpenHMD/archive/0.2.0.tar.gz"
  sha256 "b5be787229d7c7c5cb763cec6207f9814b0bb993c68842ef0a390184ca25380d"
  head "https://github.com/OpenHMD/OpenHMD.git"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "hidapi"

  conflicts_with "cspice", :because => "both install `simple` binaries"
  conflicts_with "libftdi0", :because => "both install `simple` binaries"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
    (pkgshare/"tests").install bin/"unittests"
  end

  test do
    system pkgshare/"tests/unittests"
  end
end
