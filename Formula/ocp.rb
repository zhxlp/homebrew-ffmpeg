class Ocp < Formula
  desc "UNIX port of the Open Cubic Player"
  homepage "https://sourceforge.net/projects/opencubicplayer/"
  url "https://downloads.sourceforge.net/project/opencubicplayer/ocp-0.1.21/ocp-0.1.21.tar.bz2"
  sha256 "d88eeaed42902813869911e888971ab5acd86a56d03df0821b376f2ce11230bf"



  depends_on "flac"
  depends_on "libvorbis"
  depends_on "mad"

  def install
    ENV.deparallelize

    args = %W[
      --prefix=#{prefix}
      --without-x11
      --without-sdl
      --without-desktop_file_install
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/ocp", "--help"
  end
end
