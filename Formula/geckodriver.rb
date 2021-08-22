class Geckodriver < Formula
  desc "WebDriver <-> Marionette proxy"
  homepage "https://github.com/mozilla/geckodriver"
  url "https://github.com/mozilla/geckodriver/archive/v0.23.0.tar.gz"
  sha256 "2ed7eac7c40ff3813e11410d65d8b15b05a55cb15df8413577cad03f13e5a86a"
  head "https://hg.mozilla.org/mozilla-central/", :using => :hg



  depends_on "rust" => :build

  def install
    dir = build.head? ? "testing/geckodriver" : "."
    cd(dir) { system "cargo", "install", "--root", prefix, "--path", "." }
    bin.install_symlink bin/"geckodriver" => "wires"
  end

  test do
    system bin/"geckodriver", "--help"
  end
end
