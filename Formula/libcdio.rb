class Libcdio < Formula
  desc "Compact Disc Input and Control Library"
  homepage "https://www.gnu.org/software/libcdio/"
  url "https://ftp.gnu.org/gnu/libcdio/libcdio-2.0.0.tar.gz"
  mirror "https://ftpmirror.gnu.org/libcdio/libcdio-2.0.0.tar.gz"
  sha256 "1b481b5da009bea31db875805665974e2fc568e2b2afa516f4036733657cf958"



  depends_on "pkg-config" => :build

  def install
    system "./configure", "--disable-dependency-tracking", "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match /#{version}/, shell_output("#{bin}/cd-info -v", 1)
  end
end
