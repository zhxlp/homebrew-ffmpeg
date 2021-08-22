class Plzip < Formula
  desc "Data compressor"
  homepage "https://www.nongnu.org/lzip/plzip.html"
  url "https://download.savannah.gnu.org/releases/lzip/plzip/plzip-1.7.tar.gz"
  sha256 "95e22cdd98eb2f41bf4fb169530a5945aad2fec20c2e2284d597e77972baf2b7"



  depends_on "lzlib"

  # error: unknown type name 'pthread_mutex_t' and 'pthread_cond_t'
  # Reported 24 Nov 2017 to lzip-bug AT nongnu DOT org
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/68e2af8/plzip/pthread.diff"
    sha256 "9e6653248ade666922b353b362eda6383af73c85cd93936c70bd8257e027f2b1"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "check"
    ENV.deparallelize
    system "make", "install"
  end

  test do
    text = "Hello Homebrew!"
    compressed = pipe_output("#{bin}/plzip -c", text)
    assert_equal text, pipe_output("#{bin}/plzip -d", compressed)
  end
end
