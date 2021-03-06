class Mp3cat < Formula
  desc "Reads and writes mp3 files"
  homepage "https://web.archive.org/web/20150904105157/tomclegg.net/mp3cat"
  url "https://web.archive.org/web/20150904105157/tomclegg.net/software/mp3cat-0.4.tar.gz"
  sha256 "fd2b0d58018f5117bd1e22298c899bef5e6af61a0c540186d16d2bf516d6849a"



  def install
    system "make"
    bin.install %w[mp3cat mp3log mp3log-conf mp3dirclean mp3http mp3stream-conf]
  end

  test do
    pipe_output("#{bin}/mp3cat -v --noclean - -", test_fixtures("test.mp3"))
  end
end
