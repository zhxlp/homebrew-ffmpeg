class Libnfc < Formula
  desc "Low level NFC SDK and Programmers API"
  homepage "http://nfc-tools.org"
  url "https://bintray.com/artifact/download/nfc-tools/sources/libnfc-1.7.1.tar.bz2"
  sha256 "945e74d8e27683f9b8a6f6e529557b305d120df347a960a6a7ead6cb388f4072"



  depends_on "pkg-config" => :build
  depends_on "libusb-compat"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--enable-serial-autoprobe",
                          "--with-drivers=all"
    system "make", "install"
    (prefix/"etc/nfc/libnfc.conf").write "allow_intrusive_scan=yes"
  end

  test do
    system "#{bin}/nfc-list"
  end
end
