class Shorten < Formula
  desc "Waveform compression"
  homepage "https://web.archive.org/web/20180903155129/www.etree.org/shnutils/shorten/"
  url "https://web.archive.org/web/20180903155129/www.etree.org/shnutils/shorten/dist/src/shorten-3.6.1.tar.gz"
  sha256 "ce22e0676c93494ee7d094aed9b27ad018eae5f2478e8862ae1e962346405b66"



  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/shorten", test_fixtures("test.wav"), "test"
    assert_predicate testpath/"test", :exist?
  end
end
