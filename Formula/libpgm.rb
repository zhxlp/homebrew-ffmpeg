class Libpgm < Formula
  desc "Implements the PGM reliable multicast protocol"
  homepage "https://code.google.com/archive/p/openpgm/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/openpgm/libpgm-5.2.122~dfsg.tar.gz"
  version "5.2.122"
  sha256 "e296f714d7057e3cdb87f4e29b1aecb3b201b9fcb60aa19ed4eec29524f08bd8"



  def install
    cd "openpgm/pgm" do
      system "./configure", "--disable-dependency-tracking",
                            "--prefix=#{prefix}"
      system "make", "install"
    end
  end
end
