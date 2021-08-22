class Audiofile < Formula
  desc "Reads and writes many common audio file formats"
  homepage "https://audiofile.68k.org/"
  revision 1

  stable do
    url "https://audiofile.68k.org/audiofile-0.3.6.tar.gz"
    sha256 "cdc60df19ab08bfe55344395739bb08f50fc15c92da3962fac334d3bff116965"

    # Fixes CVE-2015-7747. Fixed upstream but doesn't apply cleanly.
    # https://github.com/mpruett/audiofile/commit/b62c902dd258125cac86cd2df21fc898035a43d3
    patch do
      url "https://deb.debian.org/debian/pool/main/a/audiofile/audiofile_0.3.6-4.debian.tar.xz"
      sha256 "0620675a52bdb40b775980cc1820e308df329348bb847f9a4a8361b3799fa241"
      apply "patches/03_CVE-2015-7747.patch"
    end
  end



  head do
    url "https://github.com/mpruett/audiofile.git"
    depends_on "asciidoc" => :build
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  # These have all been reported upstream but beside
  # 03_CVE-2015-7747 not yet merged or fixed.
  # https://github.com/mpruett/audiofile/issues/31
  # https://github.com/mpruett/audiofile/issues/32
  # https://github.com/mpruett/audiofile/issues/33
  # https://github.com/mpruett/audiofile/issues/34
  # https://github.com/mpruett/audiofile/issues/35
  # https://github.com/mpruett/audiofile/issues/36
  # https://github.com/mpruett/audiofile/issues/37
  # https://github.com/mpruett/audiofile/issues/38
  # https://github.com/mpruett/audiofile/issues/39
  # https://github.com/mpruett/audiofile/issues/40
  # https://github.com/mpruett/audiofile/issues/41
  # https://github.com/mpruett/audiofile/pull/42
  patch do
    url "https://deb.debian.org/debian/pool/main/a/audiofile/audiofile_0.3.6-4.debian.tar.xz"
    sha256 "0620675a52bdb40b775980cc1820e308df329348bb847f9a4a8361b3799fa241"
    apply "patches/04_clamp-index-values-to-fix-index-overflow-in-IMA.cpp.patch",
          "patches/05_Always-check-the-number-of-coefficients.patch",
          "patches/06_Check-for-multiplication-overflow-in-MSADPCM-decodeSam.patch",
          "patches/07_Check-for-multiplication-overflow-in-sfconvert.patch",
          "patches/08_Fix-signature-of-multiplyCheckOverflow.-It-returns-a-b.patch",
          "patches/09_Actually-fail-when-error-occurs-in-parseFormat.patch",
          "patches/10_Check-for-division-by-zero-in-BlockCodec-runPull.patch"
  end

  def install
    if build.head?
      inreplace "autogen.sh", "libtool", "glibtool"
      ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"
    end

    configure = build.head? ? "./autogen.sh" : "./configure"
    args = ["--disable-dependency-tracking", "--prefix=#{prefix}"]
    system configure, *args
    system "make"
    system "make", "install"
  end

  test do
    inn  = "/System/Library/Sounds/Glass.aiff"
    out  = "Glass.wav"

    system bin/"sfconvert", inn, out, "format", "wave"
    system bin/"sfinfo", "--short", "--reporterror", out
  end
end
