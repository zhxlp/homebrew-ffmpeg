class Dshb < Formula
  desc "macOS system monitor in Swift"
  homepage "https://github.com/beltex/dshb"
  url "https://github.com/beltex/dshb/releases/download/v0.2.0/dshb-0.2.0-source.zip"
  sha256 "b2d512e743d2973ae4cddfead2c5b251c45e5f5d64baff0955bee88e94035c33"



  depends_on :xcode => ["8.0", :build]

  def install
    system "make", "release"
    bin.install "bin/dshb"
    man1.install "docs/dshb.1"
  end

  test do
    pipe_output("#{bin}/dshb", "q", 0)
  end
end
