class Ccat < Formula
  desc "Like cat but displays content with syntax highlighting"
  homepage "https://github.com/jingweno/ccat"
  url "https://github.com/jingweno/ccat/archive/v1.1.0.tar.gz"
  sha256 "b02d2c8d573f5d73595657c7854c9019d3bd2d9e6361b66ce811937ffd2bfbe1"



  depends_on "go" => :build

  conflicts_with "ccrypt", :because => "both install `ccat` binaries"

  def install
    system "./script/build"
    bin.install "ccat"
  end

  test do
    (testpath/"test.txt").write <<~EOS
      I am a colourful cat
    EOS

    assert_match(/I am a colourful cat/, shell_output("#{bin}/ccat test.txt"))
  end
end
