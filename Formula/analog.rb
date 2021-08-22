class Analog < Formula
  desc "Logfile analyzer"
  # Last known good original homepage: https://web.archive.org/web/20140822104703/analog.cx/
  homepage "https://tracker.debian.org/pkg/analog"
  url "https://deb.debian.org/debian/pool/main/a/analog/analog_6.0.orig.tar.gz"
  sha256 "31c0e2bedd0968f9d4657db233b20427d8c497be98194daf19d6f859d7f6fcca"
  revision 1



  depends_on "gd"
  depends_on "jpeg"
  depends_on "libpng"

  def install
    system "make", "CC=#{ENV.cc}",
                   "CFLAGS=#{ENV.cflags}",
                   "DEFS='-DLANGDIR=\"#{pkgshare}/lang/\"' -DHAVE_ZLIB",
                   "LIBS=-lz",
                   "OS=OSX"

    bin.install "analog"
    pkgshare.install "examples", "how-to", "images", "lang"
    pkgshare.install "analog.cfg" => "analog.cfg-dist"
    (pkgshare/"examples").install "logfile.log"
    man1.install "analog.man" => "analog.1"
  end

  test do
    output = pipe_output("#{bin}/analog #{pkgshare}/examples/logfile.log")
    assert_match /(United Kingdom)/, output
  end
end
