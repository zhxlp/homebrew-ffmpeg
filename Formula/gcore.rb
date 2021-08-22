class Gcore < Formula
  desc "Produce a snapshot (core dump) of a running process"
  homepage "https://osxbook.com/book/bonus/chapter8/core/"
  url "https://osxbook.com/book/bonus/chapter8/core/download/gcore-1.3.tar.gz"
  mirror "https://dl.bintray.com/homebrew/mirror/gcore-1.3.tar.gz"
  sha256 "6b58095c80189bb5848a4178f282102024bbd7b985f9543021a3bf1c1a36aa2a"
  revision 1



  keg_only :provided_by_macos if MacOS.version >= :sierra

  def install
    system "make"
    bin.install "gcore"
  end

  test do
    assert_match "<pid>", shell_output("#{bin}/gcore 2>&1", 22)
  end
end
