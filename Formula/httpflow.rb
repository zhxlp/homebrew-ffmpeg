class Httpflow < Formula
  desc "Packet capture and analysis utility similar to tcpdump for HTTP"
  homepage "https://github.com/six-ddc/httpflow"
  url "https://github.com/six-ddc/httpflow/archive/0.0.7.tar.gz"
  sha256 "9bcc7bc00427a4b01c5a5178113780f2321fbe2f81857c915a420df3a6b41de2"
  head "https://github.com/six-ddc/httpflow.git"



  depends_on "pcre"

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}", "CXX=#{ENV.cxx}"
  end

  test do
    system "#{bin}/httpflow", "-h"
  end
end
