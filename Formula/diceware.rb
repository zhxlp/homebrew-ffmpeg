class Diceware < Formula
  include Language::Python::Virtualenv

  desc "Passphrases to remember"
  homepage "https://github.com/ulif/diceware"
  url "https://github.com/ulif/diceware/archive/v0.9.6.tar.gz"
  sha256 "ff55832e725abff212dec1a2cb6e1c3545ae782b5f49ec91ec870a2b50e1f0e8"



  depends_on "python"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match(/(\w+)(\-(\w+)){5}/, shell_output("#{bin}/diceware -d-"))
  end
end
