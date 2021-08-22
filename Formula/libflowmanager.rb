class Libflowmanager < Formula
  desc "Flow-based measurement tasks with packet-based inputs"
  homepage "https://research.wand.net.nz/software/libflowmanager.php"
  url "https://research.wand.net.nz/software/libflowmanager/libflowmanager-3.0.0.tar.gz"
  sha256 "0866adfcdc223426ba17d6133a657d94928b4f8e12392533a27387b982178373"



  depends_on "libtrace"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
