class Libwebm < Formula
  desc "WebM container"
  homepage "https://www.webmproject.org/code/"
  url "https://github.com/webmproject/libwebm/archive/libwebm-1.0.0.27.tar.gz"
  sha256 "1332f43742aeae215fd8df1be6e363e753b17abb37447190e789299fe3edec77"



  depends_on "cmake" => :build

  def install
    mkdir "macbuild" do
      system "cmake", "..", *std_cmake_args
      system "make"
      lib.install "libwebm.a"
      bin.install %w[sample sample_muxer vttdemux webm2pes]
    end
    include.install Dir.glob("mkv*.hpp")
    include.install Dir.glob("vtt*.h")
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <mkvwriter.hpp>
      int main()
      {
        mkvmuxer::MkvWriter writer();
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-L#{lib}", "-lwebm", "-o", "test"
    system "./test"
  end
end
