class Dumb < Formula
  desc "IT, XM, S3M and MOD player library"
  homepage "https://dumb.sourceforge.io"
  url "https://downloads.sourceforge.net/project/dumb/dumb/0.9.3/dumb-0.9.3.tar.gz"
  sha256 "8d44fbc9e57f3bac9f761c3b12ce102d47d717f0dd846657fb988e0bb5d1ea33"



  def install
    (buildpath/"make/config.txt").write <<~EOS
      include make/unix.inc
      ALL_TARGETS := core core-examples core-headers
      PREFIX := #{prefix}
    EOS
    bin.mkpath
    include.mkpath
    lib.mkpath
    system "make"
    system "make", "install"
  end

  test do
    assert_match "Usage: dumb2wav", shell_output("#{bin}/dumb2wav 2>&1", 1)
  end
end
