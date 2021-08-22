class Hfsutils < Formula
  desc "Tools for reading and writing Macintosh volumes"
  homepage "https://www.mars.org/home/rob/proj/hfs/"
  url "ftp://ftp.mars.org/pub/hfs/hfsutils-3.2.6.tar.gz"
  mirror "https://fossies.org/linux/misc/old/hfsutils-3.2.6.tar.gz"
  mirror "https://ftp.osuosl.org/pub/clfs/conglomeration/hfsutils/hfsutils-3.2.6.tar.gz"
  sha256 "bc9d22d6d252b920ec9cdf18e00b7655a6189b3f34f42e58d5bb152957289840"



  def install
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}"
    bin.mkpath
    man1.mkpath
    system "make", "install"
  end

  test do
    system "dd", "if=/dev/zero", "of=disk.hfs", "bs=1k", "count=800"
    system bin/"hformat", "-l", "Test Disk", "disk.hfs"
    output = shell_output("#{bin}/hmount disk.hfs")
    assert_match /^Volume name is "Test Disk"$/, output
    assert_match /^Volume has 803840 bytes free$/, output
  end
end
