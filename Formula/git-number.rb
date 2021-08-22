class GitNumber < Formula
  desc "Use numbers for dealing with files in git"
  homepage "https://github.com/holygeek/git-number"
  url "https://github.com/holygeek/git-number/archive/1.0.1.tar.gz"
  sha256 "1b9e691bd2c16321a8b83b65f2393af1707ece77e05dab73b14b04f51e9f9a56"



  def install
    system "make", "test"
    system "make", "prefix=#{prefix}", "install"
  end

  test do
    system "#{bin}/git-number", "-v"
  end
end
