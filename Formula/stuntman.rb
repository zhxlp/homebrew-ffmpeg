class Stuntman < Formula
  desc "Implementation of the STUN protocol"
  homepage "http://www.stunprotocol.org/"
  url "http://www.stunprotocol.org/stunserver-1.2.13.tgz"
  sha256 "d336be76c23b330bcdbf7d0af9e82f1f4f9866f9caffd37062c7f44d9c272661"
  head "https://github.com/jselbie/stunserver.git"



  depends_on "boost" => :build
  depends_on "openssl"

  def install
    system "make"
    bin.install "stunserver", "stunclient", "stuntestcode"
  end

  test do
    system "#{bin}/stuntestcode"
  end
end
