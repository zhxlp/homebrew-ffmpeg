class Mkvalidator < Formula
  desc "Tool to verify Matroska and WebM files for spec conformance"
  homepage "https://www.matroska.org/downloads/mkvalidator.html"
  url "https://downloads.sourceforge.net/project/matroska/mkvalidator/mkvalidator-0.5.2.tar.bz2"
  sha256 "2e2a91062f6bf6034e8049646897095b5fc7a1639787d5fe0fcef1f1215d873b"



  resource "tests" do
    url "https://github.com/dunn/garbage/raw/c0e682836e5237eef42a000e7d00dcd4b6dcebdb/test.mka"
    sha256 "6d7cc62177ec3f88c908614ad54b86dde469dbd2b348761f6512d6fc655ec90c"
  end

  def install
    ENV.deparallelize # Otherwise there are races

    # Reported 2 Nov 2017 https://github.com/Matroska-Org/foundation-source/issues/31
    inreplace "configure", "\r", "\n"

    system "./configure"
    system "make", "-C", "mkvalidator"
    bindir = `corec/tools/coremake/system_output.sh`.chomp
    bin.install "release/#{bindir}/mkvalidator"
  end

  test do
    resource("tests").stage do
      system bin/"mkvalidator", "test.mka"
    end
  end
end
