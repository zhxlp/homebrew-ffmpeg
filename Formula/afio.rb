class Afio < Formula
  desc "Creates cpio-format archives"
  homepage "http://members.chello.nl/~k.holtman/afio.html"
  url "http://members.chello.nl/~k.holtman/afio-2.5.1.tgz"
  sha256 "363457a5d6ee422d9b704ef56d26369ca5ee671d7209cfe799cab6e30bf2b99a"
  head "https://github.com/kholtman/afio.git"



  def install
    system "make", "DESTDIR=#{prefix}"
    bin.install "afio"
    man1.install "afio.1"

    prefix.install "ANNOUNCE-2.5.1" => "ANNOUNCE"
    prefix.install %w[INSTALLATION SCRIPTS]
    share.install Dir["script*"]
  end

  test do
    path = testpath/"test"
    path.write "homebrew"
    pipe_output("#{bin}/afio -o archive", "test\n")

    system "#{bin}/afio", "-r", "archive"
    path.unlink

    system "#{bin}/afio", "-t", "archive"
    system "#{bin}/afio", "-i", "archive"
    assert_equal "homebrew", path.read.chomp
  end
end
