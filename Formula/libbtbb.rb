class Libbtbb < Formula
  desc "Bluetooth baseband decoding library"
  homepage "https://github.com/greatscottgadgets/libbtbb"
  url "https://github.com/greatscottgadgets/libbtbb/archive/2018-12-R1.tar.gz"
  version "2018-12-R1"
  sha256 "0eb2b72e1c1131538206f1e3176e2cf1048751fe7dc665eef1e7429d1f2e6225"
  head "https://github.com/greatscottgadgets/libbtbb.git"



  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    system bin/"btaptap", "-r", test_fixtures("test.pcap")
  end
end
