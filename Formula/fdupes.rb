class Fdupes < Formula
  desc "Identify or delete duplicate files"
  homepage "https://github.com/adrianlopezroche/fdupes"
  url "https://github.com/adrianlopezroche/fdupes/archive/v1.6.1.tar.gz"
  sha256 "9d6b6fdb0b8419815b4df3bdfd0aebc135b8276c90bbbe78ebe6af0b88ba49ea"
  version_scheme 1



  def install
    inreplace "Makefile", "gcc", "#{ENV.cc} #{ENV.cflags}"
    system "make", "fdupes"
    bin.install "fdupes"
    man1.install "fdupes.1"
  end

  test do
    touch "a"
    touch "b"

    dupes = shell_output("#{bin}/fdupes .").strip.split("\n").sort
    assert_equal ["./a", "./b"], dupes
  end
end
