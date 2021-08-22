class BpmTools < Formula
  desc "Detect tempo of audio files using beats-per-minute (BPM)"
  homepage "http://www.pogo.org.uk/~mark/bpm-tools/"
  url "http://www.pogo.org.uk/~mark/bpm-tools/releases/bpm-tools-0.3.tar.gz"
  sha256 "37efe81ef594e9df17763e0a6fc29617769df12dfab6358f5e910d88f4723b94"
  head "http://www.pogo.org.uk/~mark/bpm-tools.git"



  def install
    system "make"
    bin.install "bpm"
  end
end
