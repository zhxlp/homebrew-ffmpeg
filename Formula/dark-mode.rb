class DarkMode < Formula
  desc "Control the macOS dark mode from the command-line"
  homepage "https://github.com/sindresorhus/dark-mode"
  url "https://github.com/sindresorhus/dark-mode/archive/2.0.1.tar.gz"
  sha256 "edea2a21e550194204bc54fe7f68d32dcc517138ac3b12cb17855e61c3260c68"
  head "https://github.com/sindresorhus/dark-mode.git"



  depends_on :xcode => :build
  depends_on :macos => :el_capitan

  def install
    system "./build"
    bin.install "bin/dark-mode"
  end

  test do
    system "#{bin}/dark-mode", "--version"
  end
end
