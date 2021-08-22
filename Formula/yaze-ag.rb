class YazeAg < Formula
  desc "Yet Another Z80 Emulator (by AG)"
  homepage "http://www.mathematik.uni-ulm.de/users/ag/yaze-ag/"
  url "http://www.mathematik.uni-ulm.de/users/ag/yaze-ag/devel/yaze-ag-2.40.5_with_keytrans.tar.gz"
  version "2.40.5"
  sha256 "d46c861eb0725b87dd5567062f277860b98d538fca477d8686f17b36ef39d9bd"



  def install
    inreplace "Makefile_solaris_gcc", "md5sum -b", "md5"
    bin.mkpath
    system "make", "-f", "Makefile_solaris_gcc",
                   "BINDIR=#{bin}",
                   "MANDIR=#{man1}",
                   "LIBDIR=#{lib}/yaze",
                   "install"
  end

  test do
    (testpath/"cpm").mkpath
    assert_match "yazerc", shell_output("#{bin}/yaze -v", 1)
  end
end
