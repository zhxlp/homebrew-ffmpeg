class Duti < Formula
  desc "Select default apps for documents and URL schemes on macOS"
  homepage "https://github.com/moretension/duti/"
  url "https://github.com/moretension/duti/archive/duti-1.5.4.tar.gz"
  sha256 "3f8f599899a0c3b85549190417e4433502f97e332ce96cd8fa95c0a9adbe56de"
  head "https://github.com/moretension/duti.git"



  depends_on "autoconf" => :build

  # Fix compilation on macOS 10.14 Mojave
  patch do
    url "https://github.com/moretension/duti/pull/32.patch"
    sha256 "e249113e27fbcd1daca1c75598eca8cfa65f8ed2c08a276bda390b6c4148e9be"
  end

  def install
    system "autoreconf", "-vfi"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match "com.apple.TextEdit", shell_output("#{bin}/duti -l public.text"),
                 "TextEdit not found among the handlers for public.text"
  end
end
