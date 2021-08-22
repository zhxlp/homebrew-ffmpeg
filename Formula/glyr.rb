class Glyr < Formula
  desc "Music related metadata search engine with command-line interface and C API"
  homepage "https://github.com/sahib/glyr"
  url "https://github.com/sahib/glyr/archive/1.0.10.tar.gz"
  sha256 "77e8da60221c8d27612e4a36482069f26f8ed74a1b2768ebc373c8144ca806e8"



  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "glib"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    search = "--artist Beatles --album \"Please Please Me\""
    cmd = "#{bin}/glyrc cover --no-download #{search} -w stdout"
    assert_match %r{^https?://}, pipe_output(cmd, nil, 0)
  end
end
