class Clamz < Formula
  desc "Download MP3 files from Amazon's music store"
  homepage "https://code.google.com/archive/p/clamz/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/clamz/clamz-0.5.tar.gz"
  sha256 "5a63f23f15dfa6c2af00ff9531ae9bfcca0facfe5b1aa82790964f050a09832b"
  revision 1



  depends_on "pkg-config" => :build
  depends_on "libgcrypt"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/clamz --version 2>&1")
  end
end
