class Tarsnap < Formula
  desc "Online backups for the truly paranoid"
  homepage "https://www.tarsnap.com/"
  url "https://www.tarsnap.com/download/tarsnap-autoconf-1.0.39.tgz"
  sha256 "5613218b2a1060c730b6c4a14c2b34ce33898dd19b38fb9ea0858c5517e42082"



  head do
    url "https://github.com/Tarsnap/tarsnap.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "openssl"

  def install
    # dyld: lazy symbol binding failed: Symbol not found: _clock_gettime
    # Reported 20 Aug 2017 https://github.com/Tarsnap/tarsnap/issues/286
    if MacOS.version == :el_capitan && MacOS::Xcode.version >= "8.0"
      inreplace "libcperciva/util/monoclock.c", "CLOCK_MONOTONIC",
                                                "UNDEFINED_GIBBERISH"
    end

    system "autoreconf", "-iv" if build.head?

    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --with-bash-completion-dir=#{bash_completion}
      --without-lzma
      --without-lzmadec
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system bin/"tarsnap", "-c", "--dry-run", testpath
  end
end
