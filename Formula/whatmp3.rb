class Whatmp3 < Formula
  desc "Small script to create mp3 torrents out of FLACs"
  homepage "https://github.com/RecursiveForest/whatmp3"
  url "https://github.com/RecursiveForest/whatmp3/archive/v3.8.tar.gz"
  sha256 "0d8ba70a1c72835663a3fde9ba8df0ff7007268ec0a2efac76c896dea4fcf489"
  revision 2
  head "https://github.com/RecursiveForest/whatmp3.git"



  depends_on "flac"
  depends_on "lame"
  depends_on "mktorrent"
  depends_on "python"

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    (testpath/"flac").mkpath
    cp test_fixtures("test.flac"), "flac"
    system "#{bin}/whatmp3", "--notorrent", "--V0", "flac"
    assert_predicate testpath/"V0/test.mp3", :exist?
  end
end
