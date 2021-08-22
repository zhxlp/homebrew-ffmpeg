class Libdrawtext < Formula
  desc "Library for anti-aliased text rendering in OpenGL"
  homepage "http://nuclear.mutantstargoat.com/sw/libdrawtext/"
  url "https://github.com/jtsiomb/libdrawtext/archive/release_0.4.tar.gz"
  sha256 "e9460eb489e0ef6d1496afed2dae2e41c94005c85737ff53a8c09d51b6f93074"
  revision 1
  head "https://github.com/jtsiomb/libdrawtext.git"



  depends_on "pkg-config" => :build
  depends_on "freetype"

  def install
    system "./configure", "--disable-dbg", "--enable-opt", "--prefix=#{prefix}"
    system "make", "install"
    system "make", "-C", "tools/font2glyphmap"
    system "make", "-C", "tools/font2glyphmap", "PREFIX=#{prefix}", "install"
    pkgshare.install "examples"
  end

  test do
    ext = (MacOS.version >= :high_sierra) ? "otf" : "ttf"
    cp "/System/Library/Fonts/LastResort.#{ext}", testpath
    system bin/"font2glyphmap", "LastResort.#{ext}"
    bytes = File.read("LastResort_s12.glyphmap").bytes.to_a[0..12]
    assert_equal [80, 54, 10, 53, 49, 50, 32, 50, 53, 54, 10, 35, 32], bytes
  end
end
