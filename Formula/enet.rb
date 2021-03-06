class Enet < Formula
  desc "Provides a network communication layer on top of UDP"
  homepage "http://enet.bespin.org"
  url "http://enet.bespin.org/download/enet-1.3.14.tar.gz"
  sha256 "98f6f57aab0a424469619ed3047728f0d3901ce8f0dea919c11e7966d807e870"



  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end
end
