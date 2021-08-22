class Faac < Formula
  desc "ISO AAC audio encoder"
  homepage "https://www.audiocoding.com/faac.html"
  url "https://downloads.sourceforge.net/project/faac/faac-src/faac-1.29/faac-1.29.9.2.tar.gz"
  sha256 "d45f209d837c49dae6deebcdd87b8cc3b04ea290880358faecf5e7737740c771"



  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"faac", test_fixtures("test.mp3"), "-P", "-o", "test.m4a"
    assert_predicate testpath/"test.m4a", :exist?
  end
end
