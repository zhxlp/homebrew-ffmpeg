class Fonttools < Formula
  include Language::Python::Virtualenv

  desc "Library for manipulating fonts"
  homepage "https://github.com/fonttools/fonttools"
  url "https://github.com/fonttools/fonttools/releases/download/3.37.3/fonttools-3.37.3.zip"
  sha256 "c898a455a39afbe6707bc17a0e4f720ebe2087fec67683e7c86a13183078204d"
  head "https://github.com/fonttools/fonttools.git"



  depends_on "python"

  def install
    virtualenv_install_with_resources
  end

  test do
    cp "/Library/Fonts/Arial.ttf", testpath
    system bin/"ttx", "Arial.ttf"
  end
end
