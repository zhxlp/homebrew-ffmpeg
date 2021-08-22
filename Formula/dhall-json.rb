require "language/haskell"

class DhallJson < Formula
  include Language::Haskell::Cabal

  desc "Dhall to JSON compiler and a Dhall to YAML compiler"
  homepage "https://github.com/Gabriel439/Haskell-Dhall-JSON-Library"
  url "https://hackage.haskell.org/package/dhall-json-1.2.6/dhall-json-1.2.6.tar.gz"
  sha256 "9989a705a780ccc8b40f242e5dcb8949ade590a0180ae9559bffa25d829d2838"
  head "https://github.com/Gabriel439/Haskell-Dhall-JSON-Library.git"



  depends_on "cabal-install" => :build
  depends_on "ghc" => :build

  def install
    install_cabal_package
  end

  test do
    assert_match "1", pipe_output("#{bin}/dhall-to-json", "1", 0)
  end
end
