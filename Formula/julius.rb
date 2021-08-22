class Julius < Formula
  desc "Two-pass large vocabulary continuous speech recognition engine"
  homepage "https://github.com/julius-speech/julius"
  url "https://github.com/julius-speech/julius/archive/v4.4.2.1.tar.gz"
  sha256 "784730d63bcd9e9e2ee814ba8f79eef2679ec096300e96400e91f6778757567f"



  depends_on "libsndfile"

  # Upstream PR from 9 Sep 2017 "ensure pkgconfig directory exists during
  # installation"
  patch do
    url "https://github.com/julius-speech/julius/pull/73.patch?full_index=1"
    sha256 "b1d2d233a7f04f0b8f1123e1de731afd618b996d1f458ea8f53b01c547864831"
  end

  def install
    # Upstream issue "4.4.2.1 parallelized build fails"
    # Reported 10 Sep 2017 https://github.com/julius-speech/julius/issues/74
    ENV.deparallelize

    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--mandir=#{man}",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    shell_output("#{bin}/julius --help", 1)
  end
end
