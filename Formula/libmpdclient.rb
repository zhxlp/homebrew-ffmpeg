class Libmpdclient < Formula
  desc "Library for MPD in the C, C++, and Objective-C languages"
  homepage "https://www.musicpd.org/libs/libmpdclient/"
  url "https://www.musicpd.org/download/libmpdclient/2/libmpdclient-2.14.tar.xz"
  sha256 "0a84e2791bfe3077cf22ee1784c805d5bb550803dffe56a39aa3690a38061372"
  revision 1
  head "https://github.com/MusicPlayerDaemon/libmpdclient.git"



  depends_on "doxygen" => :build
  depends_on "meson-internal" => :build
  depends_on "ninja" => :build

  def install
    system "meson", "--prefix=#{prefix}", ".", "output"
    system "ninja", "-C", "output"
    system "ninja", "-C", "output", "install"
  end
end
