class Libmaa < Formula
  desc "Low-level data structures including hash tables, sets, lists"
  homepage "http://www.dict.org/"
  url "https://downloads.sourceforge.net/project/dict/libmaa/libmaa-1.4.2/libmaa-1.4.2.tar.gz"
  sha256 "63de331c97a40efe8b64534fee4b7b7df161645b92636572ad248b0f13abc0db"



  depends_on "bmake" => :build
  depends_on "mk-configure" => :build

  def install
    # not parallel safe, errors surrounding generated arggram.c
    # https://github.com/cheusov/libmaa/issues/2
    ENV.deparallelize
    system "mkcmake", "install", "CC=#{ENV.cc}", "PREFIX=#{prefix}"
  end
end
