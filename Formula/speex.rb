class Speex < Formula
  desc "Audio codec designed for speech"
  homepage "https://speex.org/"
  url "https://downloads.xiph.org/releases/speex/speex-1.2.0.tar.gz"
  sha256 "eaae8af0ac742dc7d542c9439ac72f1f385ce838392dc849cae4536af9210094"



  depends_on "pkg-config" => :build
  depends_on "libogg"

  def install
    ENV.deparallelize
    system "./configure", "--prefix=#{prefix}",
                          "--disable-debug",
                          "--disable-dependency-tracking"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <speex/speex.h>

      int main()
      {
          SpeexBits bits;
          void *enc_state;

          speex_bits_init(&bits);
          enc_state = speex_encoder_init(&speex_nb_mode);

          speex_bits_destroy(&bits);
          speex_encoder_destroy(enc_state);

          return 0;
      }
    EOS
    system ENV.cc, "-L#{lib}", "-lspeex", "test.c", "-o", "test"
    system "./test"
  end
end
