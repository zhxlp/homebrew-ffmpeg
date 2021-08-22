class Ii < Formula
  desc "Minimalist IRC client"
  homepage "https://tools.suckless.org/ii/"
  url "https://dl.suckless.org/tools/ii-1.8.tar.gz"
  sha256 "b9d9e1eae25e63071960e921af8b217ab1abe64210bd290994aca178a8dc68d2"
  head "https://git.suckless.org/ii", :using => :git



  def install
    # Fixed upstream, drop for next version
    inreplace "Makefile", "SRC = ii.c strlcpy.c", "SRC = ii.c"

    system "make", "install", "PREFIX=#{prefix}"
  end
end
