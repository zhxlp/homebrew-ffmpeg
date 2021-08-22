require "language/haskell"

class Cless < Formula
  include Language::Haskell::Cabal

  desc "Display file contents with colorized syntax highlighting"
  homepage "https://github.com/tanakh/cless"
  url "https://github.com/tanakh/cless/archive/0.3.0.0.tar.gz"
  sha256 "382ad9b2ce6bf216bf2da1b9cadd9a7561526bfbab418c933b646d03e56833b2"
  revision 1



  depends_on "cabal-install" => :build
  depends_on "ghc" => :build

  def install
    # GHC 8 compat
    # Reported 25 May 2016: https://github.com/tanakh/cless/issues/3
    # Also see "fix compilation with GHC 7.10", which has the base bump but not
    # the transformers bump: https://github.com/tanakh/cless/pull/2
    (buildpath/"cabal.config").write("allow-newer: base,transformers\n")

    install_cabal_package
  end

  test do
    system "#{bin}/cless", "--help"
    system "#{bin}/cless", "--list-langs"
    system "#{bin}/cless", "--list-styles"
  end
end
