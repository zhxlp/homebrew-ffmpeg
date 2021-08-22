class Dsd < Formula
  desc "Decoder for several digital speech formats"
  homepage "https://wiki.radioreference.com/index.php/Digital_Speech_Decoder_%28software_package%29"
  head "https://github.com/szechyjs/dsd.git"

  stable do
    url "https://github.com/szechyjs/dsd/archive/v1.6.0.tar.gz"
    sha256 "44fa3ae108d2c11b4b67388d37fc6a63e8b44fc72fdd5db7b57d9eb045a9df58"

    patch do
      # Fixes build on macOS.
      url "https://github.com/szechyjs/dsd/commit/e40c32d8addf3ab94dae42d8c0fcf9ef27e453c2.diff?full_index=1"
      sha256 "85be596a7aa9f10e86a3391e42582b2523da42ddc36d62f9c9e602ec212f5cc3"
    end
  end



  depends_on "cmake" => :build
  depends_on "itpp"
  depends_on "libsndfile"
  depends_on "portaudio"

  resource "mbelib-1.2.5" do
    url "https://github.com/szechyjs/mbelib/archive/v1.2.5.tar.gz"
    sha256 "59d5e821b976a57f1eae84dd57ba84fd980d068369de0bc6a75c92f0b286c504"
  end

  def install
    resource("mbelib-1.2.5").stage do
      # only want the static library
      inreplace "CMakeLists.txt",
        "install(TARGETS mbe-static mbe-shared DESTINATION lib)",
        "install(TARGETS mbe-static DESTINATION lib)"
      args = std_cmake_args
      args << "-DCMAKE_INSTALL_PREFIX=#{buildpath}/vendor/mbelib"
      system "cmake", ".", *args
      system "make", "install"
    end

    ENV.prepend "LDFLAGS", "-L#{buildpath}/vendor/mbelib/lib -lmbe"
    buildpath.install_symlink buildpath/"vendor/mbelib/include/mbelib.h"

    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system bin/"dsd", "-h"
  end
end
