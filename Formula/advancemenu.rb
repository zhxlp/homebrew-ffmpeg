class Advancemenu < Formula
  desc "Frontend for AdvanceMAME/MESS"
  homepage "https://www.advancemame.it/menu-readme.html"
  url "https://github.com/amadvance/advancemame/releases/download/advancemenu-2.9/advancemenu-2.9.tar.gz"
  sha256 "c7599da6ff715eb3ad9f7a55973a9aaac2f26740a4e12daf744cf08963d652c1"



  depends_on "sdl"

  conflicts_with "advancemame", :because => "both install `advmenu` binaries"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install", "LDFLAGS=#{ENV.ldflags}", "mandir=#{man}"
  end

  test do
    system bin/"advmenu", "--version"
  end
end
