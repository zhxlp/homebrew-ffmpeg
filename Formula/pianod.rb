class Pianod < Formula
  desc "Pandora client with multiple control interfaces"
  homepage "https://deviousfish.com/pianod/"
  url "https://deviousfish.com/Downloads/pianod/pianod-176.tar.gz"
  sha256 "4f3be12daef1adb3bcbbcf8ec529abf0ac018e03140be9c5b0f1203d6e1b9bf0"
  revision 1



  depends_on "pkg-config" => :build
  depends_on "faad2"
  depends_on "gnutls"
  depends_on "json-c"
  depends_on "libao"
  depends_on "libgcrypt"
  depends_on "mad"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/pianod", "-v"
  end
end
