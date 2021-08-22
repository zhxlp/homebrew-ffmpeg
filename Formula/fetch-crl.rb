class FetchCrl < Formula
  desc "Retrieve certificate revocation lists (CRLs)"
  homepage "https://wiki.nikhef.nl/grid/FetchCRL3"
  url "https://dist.eugridpma.info/distribution/util/fetch-crl3/fetch-crl-3.0.20.tar.gz"
  sha256 "cf2e145fd8855a3811b7dfeb82ed416e46ac0852dbfaa73d915cef9bd245d30d"



  def install
    system "make", "install", "PREFIX=#{prefix}", "ETC=#{etc}", "CACHE=#{var}/cache"
  end

  test do
    system sbin/"fetch-crl", "-l", testpath
  end
end
