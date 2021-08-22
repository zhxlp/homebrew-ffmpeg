class Mame < Formula
  desc "Multiple Arcade Machine Emulator"
  homepage "https://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0205.tar.gz"
  version "0.205"
  sha256 "80b7f9feb3a4da34c5c452de13d4f7db12381b8a17a90f41884ea2ca797d92ff"
  head "https://github.com/mamedev/mame.git"



  depends_on "pkg-config" => :build
  depends_on "sphinx-doc" => :build
  depends_on "flac"
  depends_on "jpeg"
  depends_on "lua"
  depends_on :macos => :yosemite
  depends_on "portaudio"
  depends_on "portmidi"
  depends_on "sdl2"
  depends_on "sqlite"
  depends_on "utf8proc"

  # Need C++ compiler and standard library support C++14.

  def install
    inreplace "scripts/src/osd/sdl.lua", "--static", ""

    # 3rdparty/sol2/sol/compatibility/version.hpp:30:10
    # fatal error: 'lua.hpp' file not found
    ENV.append "CPPFLAGS", "-I#{Formula["lua"].opt_include}/lua"

    system "make", "USE_LIBSDL=1",
                   "USE_SYSTEM_LIB_EXPAT=1",
                   "USE_SYSTEM_LIB_ZLIB=1",
                   "USE_SYSTEM_LIB_JPEG=1",
                   "USE_SYSTEM_LIB_FLAC=1",
                   "USE_SYSTEM_LIB_LUA=1",
                   "USE_SYSTEM_LIB_SQLITE3=1",
                   "USE_SYSTEM_LIB_PORTMIDI=1",
                   "USE_SYSTEM_LIB_PORTAUDIO=1",
                   "USE_SYSTEM_LIB_UTF8PROC=1"
    bin.install "mame64" => "mame"
    cd "docs" do
      system "make", "text"
      doc.install Dir["build/text/*"]
      system "make", "man"
      man1.install "build/man/MAME.1" => "mame.1"
    end
    pkgshare.install %w[artwork bgfx hash ini keymaps plugins samples uismall.bdf]
  end

  test do
    assert shell_output("#{bin}/mame -help").start_with? "MAME v#{version}"
    system "#{bin}/mame", "-validate"
  end
end
