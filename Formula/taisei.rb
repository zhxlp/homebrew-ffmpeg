class Taisei < Formula
  desc "Clone of Touhou Project shoot-em-up games"
  homepage "https://taisei-project.org/"
  url "https://github.com/taisei-project/taisei.git",
      :tag      => "v1.2",
      :revision => "46fb0f894ad269528ac7fda533c7994eddd9b758"
  revision 1



  # Yes, these are all build deps; the game copies them into the app bundle,
  # and doesn't require the Homebrew versions at runtime.
  depends_on "freetype" => :build
  depends_on "libpng" => :build
  depends_on "libzip" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "python" => :build
  depends_on "sdl2" => :build
  depends_on "sdl2_mixer" => :build
  depends_on "sdl2_ttf" => :build

  # Fixes a bug in the .app bundle build script.
  # # Will be in the next release.
  patch do
    url "https://github.com/taisei-project/taisei/commit/68b0d4f5c6f2015704e1ed1b4098be1c4336db74.patch?full_index=1"
    sha256 "cb1f79826e632a61daa271cb59d0a80ab77dea876d384c381ab66d5eb9b9bd27"
  end

  def install
    mkdir "build" do
      system "meson", "--prefix=#{prefix}", "-Ddocs=false", ".."
      system "ninja"
      system "ninja", "install"
    end
  end

  def caveats
    "Sound may not work."
  end

  test do
    output = shell_output("#{prefix}/Taisei.app/Contents/MacOS/Taisei -h", 1)
    assert_match "Touhou clone", output
  end
end
