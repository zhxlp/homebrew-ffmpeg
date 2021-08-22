class Airspy < Formula
  desc "The usemode driver and associated tools for airspy"
  homepage "https://airspy.com/"
  url "https://github.com/airspy/airspyone_host/archive/v1.0.9.tar.gz"
  sha256 "967ef256596d4527b81f007f77b91caec3e9f5ab148a8fec436a703db85234cc"
  head "https://github.com/airspy/airspyone_host.git"



  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "libusb"

  def install
    args = std_cmake_args

    libusb = Formula["libusb"]
    args << "-DLIBUSB_INCLUDE_DIR=#{libusb.opt_include}/libusb-1.0"
    args << "-DLIBUSB_LIBRARIES=#{libusb.opt_lib}/libusb-1.0.dylib"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/airspy_lib_version").chomp
  end
end
