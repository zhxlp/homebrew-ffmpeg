class Tlsdate < Formula
  desc "Secure rdate replacement"
  homepage "https://www.github.com/ioerror/tlsdate/"
  url "https://github.com/ioerror/tlsdate/archive/tlsdate-0.0.13.tar.gz"
  sha256 "90efdff87504b5159cb6a3eefa9ddd43723c073d49c4b3febba9e48fc1292bf9"
  head "https://github.com/ioerror/tlsdate.git"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libevent" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "openssl"

  # Upstream PR to fix the build on macOS
  patch do
    url "https://github.com/ioerror/tlsdate/pull/160.patch?full_index=1"
    sha256 "c2af25386fd7ffa889e421e864fdd72bbf90f2551347e6155ad7fb7b13122b90"
  end

  def install
    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/tlsdate", "--verbose", "--dont-set-clock"
  end
end
