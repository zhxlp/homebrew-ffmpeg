require "language/haskell"

class Cryptol < Formula
  include Language::Haskell::Cabal

  desc "Domain-specific language for specifying cryptographic algorithms"
  homepage "https://www.cryptol.net/"
  url "https://hackage.haskell.org/package/cryptol-2.6.0/cryptol-2.6.0.tar.gz"
  sha256 "5f8abbfa2765ac0f6bb887edbec7032677d107c39581a4c78614e97382738f42"
  head "https://github.com/GaloisInc/cryptol.git"



  depends_on "cabal-install" => :build
  depends_on "ghc" => :build
  depends_on "z3"

  def install
    install_cabal_package :using => ["alex", "happy"]
  end

  test do
    (testpath/"helloworld.icry").write <<~EOS
      :prove \\(x : [8]) -> x == x
      :prove \\(x : [32]) -> x + zero == x
    EOS
    expected = /Q\.E\.D\..*Q\.E\.D/m
    assert_match expected, shell_output("#{bin}/cryptol -b helloworld.icry")
  end
end
