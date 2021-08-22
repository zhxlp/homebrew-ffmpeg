class Srtp < Formula
  desc "Implementation of the Secure Real-time Transport Protocol"
  homepage "https://github.com/cisco/libsrtp"
  url "https://github.com/cisco/libsrtp/archive/v2.2.0.tar.gz"
  sha256 "44fd7497bce78767e96b54a11bca520adb2ad32effd515f04bce602b60a1a50b"
  head "https://github.com/cisco/libsrtp.git"



  depends_on "pkg-config" => :build

  def install
    system "./configure", "--disable-debug", "--prefix=#{prefix}"
    system "make", "test"
    system "make", "shared_library"
    system "make", "install" # Can't go in parallel of building the dylib
    libexec.install "test/rtpw"
  end

  test do
    system libexec/"rtpw", "-l"
  end
end
