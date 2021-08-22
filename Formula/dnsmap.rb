class Dnsmap < Formula
  desc "Passive DNS network mapper (a.k.a. subdomains bruteforcer)"
  homepage "https://code.google.com/archive/p/dnsmap/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/dnsmap/dnsmap-0.30.tar.gz"
  sha256 "fcf03a7b269b51121920ac49f7d450241306cfff23c76f3da94b03792f6becbc"



  def install
    system "make", "CC=#{ENV.cc}", "CFLAGS=#{ENV.cflags}",
                   "BINDIR=#{bin}", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dnsmap", 1)
  end
end
