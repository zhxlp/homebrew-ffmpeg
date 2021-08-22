class Nuttcp < Formula
  desc "Network performance measurement tool"
  homepage "https://www.nuttcp.net/nuttcp"
  url "https://www.nuttcp.net/nuttcp/nuttcp-8.1.4.tar.bz2"
  sha256 "737f702ec931ec12fcf54e66c4c1d5af72bd3631439ffa724ed2ac40ab2de78d"



  def install
    system "make", "APP=nuttcp",
           "CC=#{ENV.cc}", "CFLAGS=#{ENV.cflags}"
    bin.install "nuttcp"
    man8.install "nuttcp.cat" => "nuttcp.8"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nuttcp -V")
  end
end
