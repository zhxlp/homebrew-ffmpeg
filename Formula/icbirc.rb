class Icbirc < Formula
  desc "Proxy IRC client and ICB server"
  homepage "https://www.benzedrine.ch/icbirc.html"
  url "https://www.benzedrine.ch/icbirc-2.1.tar.gz"
  sha256 "6839344d93c004da97ec6bb5d805a1db7e0a79efc3870445788043627162bbb1"



  depends_on "bsdmake" => :build

  def install
    system "bsdmake"
    bin.install "icbirc"
    man8.install "icbirc.8"
  end
end
