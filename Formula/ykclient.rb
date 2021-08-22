class Ykclient < Formula
  desc "Library to validate YubiKey OTPs against YubiCloud"
  homepage "https://developers.yubico.com/yubico-c-client/"
  url "https://developers.yubico.com/yubico-c-client/Releases/ykclient-2.15.tar.gz"
  sha256 "f461cdefe7955d58bbd09d0eb7a15b36cb3576b88adbd68008f40ea978ea5016"



  head do
    url "https://github.com/Yubico/yubico-c-client.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "help2man" => :build
  depends_on "pkg-config" => :build

  def install
    system "autoreconf", "-iv" if build.head?
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
    system "make", "check"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/ykclient --version").chomp
  end
end
