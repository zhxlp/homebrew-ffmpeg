class Blink1 < Formula
  desc "Control blink(1) indicator light"
  homepage "https://blink1.thingm.com/"
  url "https://github.com/todbot/blink1-tool.git",
      :tag      => "v2.0.2",
      :revision => "ddea93375101a9b43e0248205b5460a0e3b45f74"
  head "https://github.com/todbot/blink1-tool.git"



  def install
    system "make"
    bin.install "blink1-tool"
    lib.install "libBlink1.dylib"
    include.install "blink1-lib.h"
  end

  test do
    system bin/"blink1-tool", "--version"
  end
end
