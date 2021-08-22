class Libpst < Formula
  desc "Utilities for the PST file format"
  homepage "https://www.five-ten-sg.com/libpst/"
  url "https://www.five-ten-sg.com/libpst/packages/libpst-0.6.72.tar.gz"
  sha256 "8a19d891eb077091c507d98ed8e2d24b7f48b3e82743bcce2b00a12040f5d507"
  revision 2



  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "gettext"
  depends_on "libgsf"

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --disable-python
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system bin/"lspst", "-V"
  end
end
