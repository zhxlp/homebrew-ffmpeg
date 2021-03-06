class Xsw < Formula
  desc "Slide show presentation tool"
  homepage "https://code.google.com/archive/p/xsw/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/xsw/xsw-0.3.5.tar.gz"
  sha256 "d7f86047716d9c4d7b2d98543952d59ce871c7d11c63653f2e21a90bcd7a6085"



  depends_on "sdl"
  depends_on "sdl_gfx"
  depends_on "sdl_image"
  depends_on "sdl_ttf"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"xsw", "-v"
  end
end
