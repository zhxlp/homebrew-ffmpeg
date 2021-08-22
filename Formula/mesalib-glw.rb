class MesalibGlw < Formula
  desc "Open-source implementation of the OpenGL specification"
  homepage "https://www.mesa3d.org"
  url "https://mesa.freedesktop.org/archive/glw/glw-8.0.0.tar.bz2"
  sha256 "2da1d06e825f073dcbad264aec7b45c649100e5bcde688ac3035b34c8dbc8597"



  depends_on "pkg-config" => :build
  depends_on :x11

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    system "make", "install"
  end
end
