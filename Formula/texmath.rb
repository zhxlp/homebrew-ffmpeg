require "language/haskell"

class Texmath < Formula
  include Language::Haskell::Cabal

  desc "Haskell library for converting LaTeX math to MathML"
  homepage "https://johnmacfarlane.net/texmath.html"
  url "https://hackage.haskell.org/package/texmath-0.11.1.1/texmath-0.11.1.1.tar.gz"
  sha256 "c6f5a6dc010d23c2c38dc4fbc62d7c36d3d1c80d5ceb6a0e4b472b8278f4dbeb"



  depends_on "cabal-install" => :build
  depends_on "ghc" => :build

  def install
    install_cabal_package "--enable-tests", :flags => ["executable"] do
      system "cabal", "test"
    end
  end

  test do
    assert_match "<mn>2</mn>", pipe_output(bin/"texmath", "a^2 + b^2 = c^2")
  end
end
