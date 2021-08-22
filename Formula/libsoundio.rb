class Libsoundio < Formula
  desc "Cross-platform audio input and output"
  homepage "http://libsound.io"
  url "https://github.com/andrewrk/libsoundio/archive/1.1.0.tar.gz"
  sha256 "ba0b21397cb3e29dc8f51ed213ae27625f05398c01aefcfbaa860fab42a84281"



  depends_on "cmake" => :build

  # fatal error: 'stdatomic.h' file not found
  depends_on :macos => :yosemite

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <soundio/soundio.h>

      int main() {
        struct SoundIo *soundio = soundio_create();

        if (!soundio) { return 1; }
        if (soundio_connect(soundio)) return 1;

        soundio_flush_events(soundio);
        soundio_destroy(soundio);

        return 0;
      }
    EOS
    system ENV.cc, "-L#{lib}", "-lsoundio", "test.c", "-o", "test"
    system "./test"
  end
end
