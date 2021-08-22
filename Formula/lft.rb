class Lft < Formula
  desc "Layer Four Traceroute (LFT), an advanced traceroute tool"
  homepage "https://pwhois.org/lft/"
  url "https://pwhois.org/dl/index.who?file=lft-3.79.tar.gz"
  sha256 "08e5c7973551b529c850bffbc7152c4e5f0bcb1f07ebbb39151a7dc9a3bf9de0"



  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lft -v 2>&1")
  end
end
