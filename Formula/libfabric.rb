class Libfabric < Formula
  desc "OpenFabrics libfabric"
  homepage "https://ofiwg.github.io/libfabric/"
  url "https://github.com/ofiwg/libfabric/releases/download/v1.6.2/libfabric-1.6.2.tar.bz2"
  sha256 "ec63f61f5e529964ef65fd101627d8782c0efc2b88b3d5fc7f0bfd2c1e95ab2c"
  head "https://github.com/ofiwg/libfabric.git"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool"  => :build

  def install
    system "autoreconf", "-fiv"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#(bin}/fi_info"
  end
end
