class Mfoc < Formula
  desc "Implementation of 'offline nested' attack by Nethemba"
  homepage "https://github.com/nfc-tools/mfoc"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mfoc/mfoc-0.10.7.tar.bz2"
  sha256 "93d8ac4cb0aa6ed94855ca9732a2ffd898a9095c087f12f9402205443c2eb98c"



  depends_on "pkg-config" => :build
  depends_on "libnfc"
  depends_on "libusb"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"mfoc", "-h"
  end
end
