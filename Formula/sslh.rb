class Sslh < Formula
  desc "Forward connections based on first data packet sent by client"
  homepage "https://www.rutschle.net/tech/sslh.shtml"
  url "https://www.rutschle.net/tech/sslh/sslh-v1.19c.tar.gz"
  sha256 "bb11dfa88b27ae1ec825a1b8156000c3f17f7e8f042311f19b7a249193c47bf3"
  head "https://github.com/yrutschle/sslh.git"



  depends_on "libconfig"
  depends_on "pcre"

  def install
    ENV.deparallelize
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_match version.to_s, shell_output("#{sbin}/sslh -V")
  end
end
