class Abcde < Formula
  desc "Better CD Encoder"
  homepage "https://abcde.einval.com"
  url "https://abcde.einval.com/download/abcde-2.9.2.tar.gz"
  sha256 "34356c6ea4cc39b33c807261bfdf8e8da8905b2ed50313147c78b283eef6858d"
  revision 1
  head "https://git.einval.com/git/abcde.git"



  depends_on "cd-discid"
  depends_on "cdrtools"
  depends_on "flac"
  depends_on "glyr"
  depends_on "id3v2"
  depends_on "lame"
  depends_on "mkcue"
  depends_on "vorbis-tools"

  def install
    system "make", "install", "prefix=#{prefix}", "sysconfdir=#{etc}"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/abcde -v")
  end
end
