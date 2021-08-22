class Remake < Formula
  desc "GNU Make with improved error handling, tracing, and a debugger"
  homepage "https://bashdb.sourceforge.io/remake"
  url "https://downloads.sourceforge.net/project/bashdb/remake/4.2%2Bdbg-1.4/remake-4.2.1%2Bdbg-1.4.tar.bz2"
  version "4.2.1-1.4"
  sha256 "55df3b2586ab90ac0983a049f1911c4a1d9b68f7715c69768fbb0405e96a0e7b"



  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"Makefile").write <<~EOS
      all:
      \techo "Nothing here, move along"
    EOS
    system bin/"remake", "-x"
  end
end
