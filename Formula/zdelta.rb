class Zdelta < Formula
  desc "Lossless delta compression library"
  homepage "https://web.archive.org/web/20150804051750/cis.poly.edu/zdelta/"
  url "https://web.archive.org/web/20150804051752/cis.poly.edu/zdelta/downloads/zdelta-2.1.tar.gz"
  sha256 "03e6beb2e1235f2091f0146d7f41dd535aefb6078a48912d7d11973d5306de4c"
  head "https://github.com/snej/zdelta.git"



  def install
    system "make", "test", "CC=#{ENV.cc}", "CFLAGS=#{ENV.cflags}"
    system "make", "install", "prefix=#{prefix}"
    bin.install "zdc", "zdu"
  end

  test do
    msg = "Hello this is Homebrew"
    (testpath/"ref").write "Hello I'm a ref file"

    compressed = pipe_output("#{bin}/zdc ref", msg, 0)

    assert_equal msg, pipe_output("#{bin}/zdu ref", compressed, 0)
  end
end
