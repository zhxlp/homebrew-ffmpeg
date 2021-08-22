class Primer3 < Formula
  desc "Program for designing PCR primers"
  homepage "https://primer3.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/primer3/primer3/2.4.0/primer3-2.4.0.tar.gz"
  sha256 "6d537640c86e2b4656ae77f75b6ad4478fd0ca43985a56cce531fb9fc0431c47"



  def install
    cd "src" do
      system "make"

      # Lack of make install target reported to upstream
      # https://github.com/primer3-org/primer3/issues/1
      bin.install %w[primer3_core ntdpal ntthal oligotm long_seq_tm_test]
      pkgshare.install "primer3_config"
    end
  end

  test do
    output = shell_output("#{bin}/long_seq_tm_test AAAAGGGCCCCCCCCTTTTTTTTTTT 3 20")
    assert_match "tm = 52.452902", output.lines.last
  end
end
