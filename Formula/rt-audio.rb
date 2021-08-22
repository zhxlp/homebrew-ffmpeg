class RtAudio < Formula
  desc "API for realtime audio input/output"
  homepage "https://www.music.mcgill.ca/~gary/rtaudio/"
  url "https://www.music.mcgill.ca/~gary/rtaudio/release/rtaudio-5.0.0.tar.gz"
  sha256 "799deae1192da52cc2c15a078ed3b42449580be7d096fe9bc841c5bba0289c57"
  head "https://github.com/thestk/rtaudio.git"



  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      lib.install "librtaudio_static.a", "librtaudio.dylib"
    end
    include.install "RtAudio.h", Dir["include/*"]
    prefix.install "contrib", "tests"
    doc.install Dir["doc/*"]
  end

  test do
    system ENV.cxx, "-I#{include}", "-L#{lib}", "-lrtaudio",
           prefix/"tests/testall.cpp", "-o", "test"
    system "./test"
  end
end
