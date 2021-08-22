class Pachi < Formula
  desc "Software for the Board Game of Go/Weiqi/Baduk"
  homepage "http://pachi.or.cz/"
  url "https://repo.or.cz/pachi.git/snapshot/pachi-11.00-retsugen.tar.gz"
  sha256 "2aaf9aba098d816d20950d283c8eaed522f3fa71f68390a4c384c0c1ab03cd6f"
  revision 1
  head "https://github.com/pasky/pachi.git"



  fails_with :clang if MacOS.version == :mavericks

  resource "patterns" do
    url "https://sainet-dist.s3.amazonaws.com/pachi_patterns.zip"
    sha256 "73045eed2a15c5cb54bcdb7e60b106729009fa0a809d388dfd80f26c07ca7cbc"
  end

  resource "book" do
    url "https://gnugo.baduk.org/books/ra6.zip"
    sha256 "1e7ffc75c424e94338308c048aacc479da6ac5cbe77c0df8adc733956872485a"
  end

  def install
    ENV["MAC"] = "1"
    ENV["DOUBLE_FLOATING"] = "1"

    system "make"
    bin.install "pachi"

    pkgshare.install resource("patterns")
    pkgshare.install resource("book")
  end

  def caveats; <<~EOS
    This formula also downloads additional data, such as opening books
    and pattern files. They are stored in #{opt_pkgshare}.

    At present, pachi cannot be pointed to external files, so make sure
    to set the working directory to #{opt_pkgshare} if you want pachi
    to take advantage of these additional files.
  EOS
  end

  test do
    assert_match /^= [A-T][0-9]+$/, pipe_output("#{bin}/pachi", "genmove b\n", 0)
  end
end
