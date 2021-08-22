class Libdvbpsi < Formula
  desc "Library to decode/generate MPEG TS and DVB PSI tables"
  homepage "https://www.videolan.org/developers/libdvbpsi.html"
  url "https://download.videolan.org/pub/libdvbpsi/1.3.2/libdvbpsi-1.3.2.tar.bz2"
  sha256 "ac4e39f2b9b1e15706ad261fa175a9430344d650a940be9aaf502d4cb683c5fe"



  def install
    system "./configure", "--prefix=#{prefix}", "--disable-debug", "--disable-dependency-tracking", "--enable-release"
    system "make", "install"
  end
end
