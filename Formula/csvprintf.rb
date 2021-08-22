class Csvprintf < Formula
  desc "Command-line utility for parsing CSV files"
  homepage "https://github.com/archiecobbs/csvprintf"
  url "https://github.com/archiecobbs/csvprintf/archive/1.0.4.tar.gz"
  sha256 "022188ced570203d6084e6eab68f7ad96054a4ab8aa54db1857a8fd076280568"



  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    ENV.append "LDFLAGS", "-liconv"
    system "./autogen.sh"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_equal "Fred Smith\n",
                 pipe_output("#{bin}/csvprintf -i '%2$s %1$s\n'", "Last,First\nSmith,Fred\n")
  end
end
