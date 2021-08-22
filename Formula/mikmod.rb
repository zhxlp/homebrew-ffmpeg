class Mikmod < Formula
  desc "Portable tracked music player"
  homepage "https://mikmod.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/mikmod/mikmod/3.2.8/mikmod-3.2.8.tar.gz"
  sha256 "dbb01bc36797ce25ffcab2b3bf625537b85b42534344e1808236ca612fbaa4cc"



  depends_on "libmikmod"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mikmod -V")
  end
end
