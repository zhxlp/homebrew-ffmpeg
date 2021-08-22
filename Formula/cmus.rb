class Cmus < Formula
  desc "Music player with an ncurses based interface"
  homepage "https://cmus.github.io/"
  url "https://github.com/cmus/cmus/archive/v2.8.0.tar.gz"
  sha256 "756ce2c6241b2104dc19097488225de559ac1802a175be0233cfb6fbc02f3bd2"
  head "https://github.com/cmus/cmus.git"



  depends_on "pkg-config" => :build
  depends_on "faad2"
  depends_on "flac"
  depends_on "libao"
  depends_on "libcue"
  depends_on "libogg"
  depends_on "libvorbis"
  depends_on "mad"
  depends_on "mp4v2"

  def install
    system "./configure", "prefix=#{prefix}", "mandir=#{man}"
    system "make", "install"
  end

  test do
    system "#{bin}/cmus", "--plugins"
  end
end
