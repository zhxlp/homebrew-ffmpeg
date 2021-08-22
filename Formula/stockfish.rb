class Stockfish < Formula
  desc "Strong open-source chess engine"
  homepage "https://stockfishchess.org/"
  url "https://github.com/official-stockfish/Stockfish/files/2629649/sf_10.zip"
  sha256 "9c2aa8b06935c930e80cba1426e10d76b6b1accc5a769e6bf1f41e15d79cadda"
  head "https://github.com/official-stockfish/Stockfish.git"



  def install
    arch = if MacOS.version.requires_popcnt?
      "x86-64-modern"
    else
      "x86-64"
    end

    system "make", "-C", "src", "build", "ARCH=#{arch}"
    bin.install "src/stockfish"
  end

  test do
    system "#{bin}/stockfish", "go", "depth", "20"
  end
end
