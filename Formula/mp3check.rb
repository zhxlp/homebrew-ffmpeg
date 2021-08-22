class Mp3check < Formula
  desc "Tool to check mp3 files for consistency"
  homepage "https://code.google.com/archive/p/mp3check/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mp3check/mp3check-0.8.7.tgz"
  sha256 "27d976ad8495671e9b9ce3c02e70cb834d962b6fdf1a7d437bb0e85454acdd0e"



  def install
    ENV.deparallelize
    # The makefile's install target is kinda iffy, but there's
    # only one file to install so it's easier to do it ourselves
    system "make"
    bin.install "mp3check"
  end

  test do
    assert version.to_s, shell_output("#{bin}/mp3check --version")
  end
end
