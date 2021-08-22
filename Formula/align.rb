class Align < Formula
  desc "Text column alignment filter"
  homepage "https://www.cs.indiana.edu/~kinzler/align/"
  url "https://www.cs.indiana.edu/~kinzler/align/align-1.7.5.tgz"
  sha256 "cc692fb9dee0cc288757e708fc1a3b6b56ca1210ca181053a371cb11746969dd"



  conflicts_with "speech-tools", :because => "both install `align` binaries"

  def install
    system "make", "install", "BINDIR=#{bin}"
  end

  test do
    assert_equal " 1  1\n12 12\n", pipe_output(bin/"align", "1 1\n12 12\n")
  end
end
