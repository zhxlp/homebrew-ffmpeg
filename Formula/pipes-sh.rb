class PipesSh < Formula
  desc "Animated pipes terminal screensaver"
  homepage "https://github.com/pipeseroni/pipes.sh"
  url "https://github.com/pipeseroni/pipes.sh/archive/v1.3.0.tar.gz"
  sha256 "532976dd8dc2d98330c45a8bcb6d7dc19e0b0e30bba8872dcce352361655a426"
  head "https://github.com/pipeseroni/pipes.sh.git"



  depends_on "bash"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/pipes.sh -v").strip.split[-1]
  end
end
