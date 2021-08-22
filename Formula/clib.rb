class Clib < Formula
  desc "Package manager for C programming"
  homepage "https://github.com/clibs/clib"
  url "https://github.com/clibs/clib/archive/1.8.1.tar.gz"
  sha256 "f5718e316771571971cb4e5a0142f91b47c6bfe32997fd869fc5a90ec091a066"
  head "https://github.com/clibs/clib.git"



  def install
    ENV["PREFIX"] = prefix
    system "make", "install"
  end

  test do
    system "#{bin}/clib", "install", "stephenmathieson/rot13.c"
  end
end
