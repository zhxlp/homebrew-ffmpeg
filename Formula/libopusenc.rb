class Libopusenc < Formula
  desc "Convenience libraray for creating .opus files"
  homepage "https://opus-codec.org/"
  url "https://archive.mozilla.org/pub/opus/libopusenc-0.2.1.tar.gz"
  sha256 "8298db61a8d3d63e41c1a80705baa8ce9ff3f50452ea7ec1c19a564fe106cbb9"



  head do
    url "https://git.xiph.org/libopusenc.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "opus"

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <opusenc.h>
      #include <assert.h>
      #include <stdint.h>
      #include <stdlib.h>
      int main() {
        OggOpusComments *comments = ope_comments_create();
        assert(comments);
        ope_comments_add(comments, "ARTIST", "Homebrew");
        ope_comments_add(comments, "TITLE", "Test Track");

        int error;
        OggOpusEnc *enc = ope_encoder_create_file("test.opus",
          comments, 48000, 2, 0, &error);;
        assert(error == OPE_OK);
        assert(enc);
        ope_comments_destroy(comments);

        int16_t *buffer = calloc(1920, 2*sizeof(*buffer));
        error = ope_encoder_write(enc, buffer, 1920*2*sizeof(*buffer));
        assert(error == OPE_OK);

        error = ope_encoder_drain(enc);
        assert(error == OPE_OK);
        ope_encoder_destroy(enc);

        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-o", "test", "-Wall",
                   "-I#{Formula["opus"].opt_include}/opus",
                   "-I#{include}/opus",
                   "-L#{lib}", "-lopusenc"
    system "./test"
  end
end
