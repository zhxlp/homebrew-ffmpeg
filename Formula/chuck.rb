class Chuck < Formula
  desc "Concurrent, on-the-fly audio programming language"
  homepage "http://chuck.cs.princeton.edu/"
  url "http://chuck.cs.princeton.edu/release/files/chuck-1.4.0.0.tgz"
  sha256 "2caee332b8d48e2fddad0f8a0a1811b6cf4c5afab73ae8a17b85ec759cce27ac"



  depends_on :xcode => :build

  def install
    # Support for newer macOS versions
    inreplace "src/core/makefile.x/makefile.osx",
              "10\\.(6|7|8|9|10|11|12|13)",
              "10\\.(6|7|8|9|10|11|12|1[0-9])"

    system "make", "-C", "src", "osx"
    bin.install "src/chuck"
    pkgshare.install "examples"
  end

  test do
    assert_match "device", shell_output("#{bin}/chuck --probe 2>&1")
  end
end
