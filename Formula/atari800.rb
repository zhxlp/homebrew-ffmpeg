class Atari800 < Formula
  desc "Atari 8-bit machine emulator"
  homepage "https://atari800.github.io/"
  url "https://downloads.sourceforge.net/project/atari800/atari800/4.0.0/atari800-4.0.0.tar.gz"
  sha256 "08e9b989ddb2785265d242ff92b416a2b53c285c7309f3fc3f5e94889cb69eb5"



  depends_on "libpng"
  depends_on "sdl"

  def install
    cd "src" do
      system "./configure", "--prefix=#{prefix}",
                            "--disable-sdltest"
      system "make", "install"
    end
  end

  test do
    assert_equal "Atari 800 Emulator, Version #{version}",
                 shell_output("#{bin}/atari800 -v", 3).strip
  end
end
