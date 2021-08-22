class Vgmstream < Formula
  desc "Library for playing streamed audio formats from video games"
  homepage "https://hcs64.com/vgmstream.html"
  url "https://github.com/kode54/vgmstream/archive/r1040.tar.gz"
  version "r1040"
  sha256 "0ff6534a4049b27b01caf209811b87b1bfe445f94e141a5fe601f2dae9d03c89"
  head "https://github.com/kode54/vgmstream.git"



  depends_on "libvorbis"
  depends_on "mpg123"

  def install
    cd "test" do
      system "make"
      bin.install "test" => "vgmstream"
      lib.install "../src/libvgmstream.a"
    end
  end

  test do
    assert_match "decode", shell_output("#{bin}/vgmstream 2>&1", 1)
  end
end
