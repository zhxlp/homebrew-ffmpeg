class Rfcmarkup < Formula
  desc "Add HTML markup and links to internet-drafts and RFCs"
  homepage "https://tools.ietf.org/tools/rfcmarkup/"
  url "https://tools.ietf.org/tools/rfcmarkup/rfcmarkup-1.119.tgz"
  sha256 "46c5522f3cba0d430019a60de0e995adbc12f055970b6b341f45181cf8deed8e"



  def install
    bin.install "rfcmarkup"
  end

  test do
    system bin/"rfcmarkup", "--help"
  end
end
