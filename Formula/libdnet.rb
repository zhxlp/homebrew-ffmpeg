class Libdnet < Formula
  desc "Portable low-level networking library"
  homepage "https://github.com/dugsong/libdnet"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/libdnet/libdnet-1.12.tgz"
  sha256 "83b33039787cf99990e977cef7f18a5d5e7aaffc4505548a83d31bd3515eb026"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "python@2" # does not support Python 3

  def install
    # autoreconf to get '.dylib' extension on shared lib
    ENV.append_path "ACLOCAL_PATH", "config"
    system "autoreconf", "-ivf"

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--with-python"
    system "make", "install"
  end

  test do
    system "#{bin}/dnet-config", "--version"
  end
end
