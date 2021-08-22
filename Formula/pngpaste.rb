class Pngpaste < Formula
  desc "Paste PNG into files"
  homepage "https://github.com/jcsalterego/pngpaste"
  url "https://github.com/jcsalterego/pngpaste/archive/0.2.2.tar.gz"
  sha256 "f7566b4eba94916df5723cdcef8e325ee7151c530eec025e996d0e784293362c"



  # Sierra's CLT is sufficient, but El Capitain's isn't
  depends_on :xcode => ["8.0", :build] if MacOS.version < :sierra

  depends_on :macos => :el_capitan # needs NSBitmapImageFileTypePNG, etc.

  def install
    system "make", "all"
    bin.install "pngpaste"
  end

  test do
    png = test_fixtures("test.png")
    system "osascript", "-e", "set the clipboard to POSIX file (\"#{png}\")"
    system bin/"pngpaste", "test.png"
    assert_predicate testpath/"test.png", :exist?
  end
end
