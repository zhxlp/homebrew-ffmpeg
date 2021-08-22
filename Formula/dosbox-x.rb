class DosboxX < Formula
  desc "DOSBox with accurate emulation and wide testing"
  homepage "http://dosbox-x.com/"
  url "https://github.com/joncampbell123/dosbox-x/archive/dosbox-x-v0.82.14.tar.gz"
  sha256 "eda33f10a369fe81d5a4bc6250ca97d3b707cc45e79be66ccfa410174ba77aef"
  version_scheme 1
  head "https://github.com/joncampbell123/dosbox-x.git"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "fluid-synth"

  def install
    ENV.cxx11

    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-sdltest
    ]
    system "./build-macosx", *args
    system "make", "install"
  end

  test do
    assert_match /DOSBox version #{version}/, shell_output("#{bin}/dosbox-x -version 2>&1", 1)
  end
end
