class Openrtsp < Formula
  desc "Command-line RTSP client"
  homepage "http://www.live555.com/openRTSP"
  url "http://www.live555.com/liveMedia/public/live.2018.10.17.tar.gz"
  # Keep a mirror as upstream tarballs are removed after each version
  mirror "https://download.videolan.org/pub/videolan/testing/contrib/live555/live.2018.10.17.tar.gz"
  sha256 "7c68d9c95b39acd309a2b6a4fc14c3837544a9be3f64062ed38d1ad6f68dc9e8"



  def install
    system "./genMakefiles", "macosx"
    system "make", "PREFIX=#{prefix}", "install"

    # Move the testing executables out of the main PATH
    libexec.install Dir.glob(bin/"test*")
  end

  def caveats; <<~EOS
    Testing executables have been placed in:
      #{libexec}
  EOS
  end

  test do
    assert_match "GNU", shell_output("#{bin}/live555ProxyServer 2>&1", 1)
  end
end
