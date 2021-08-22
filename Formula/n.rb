class N < Formula
  desc "Node version management"
  homepage "https://github.com/tj/n"
  url "https://github.com/tj/n/archive/v2.1.12.tar.gz"
  sha256 "fdcd2f19cee7fdbe1e5584e06bd12106fbc283bbb41b2188acbddf3280068ea1"
  head "https://github.com/tj/n.git"



  def install
    bin.mkdir
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system bin/"n", "ls"
  end
end
