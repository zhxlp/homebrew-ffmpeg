class Wumpus < Formula
  desc "Exact clone of the ancient BASIC Hunt the Wumpus game"
  homepage "http://www.catb.org/~esr/wumpus/"
  url "http://www.catb.org/~esr/wumpus/wumpus-1.6.tar.gz"
  sha256 "965e49b3e53f44023994b42b3aa568ad79d3a2287bb0a07460b601500c9ae16d"



  # Patches to allow `make install` to specify a prefix; both patches
  # can be removed in the next release
  patch do
    url "https://gitlab.com/esr/wumpus/commit/ea272d4786a55dbaa493d016324b7a05b4f165b9.diff"
    sha256 "7b95a5e12447b69d0958cf00bb6413a42612ffea47cdf483c6225a1980f97fb0"
  end
  patch do
    url "https://gitlab.com/esr/wumpus/commit/99022db86e54c3338d6a670f219a0845fd531530.diff"
    sha256 "143cba3992b27addb8e25e245624902b935b29cc5465cbe947dd5ae573dafdca"
  end

  def install
    system "make"
    system "make", "prefix=#{prefix}", "install"
  end

  test do
    assert_match("HUNT THE WUMPUS",
                 pipe_output(bin/"wumpus", "^C"))
  end
end
