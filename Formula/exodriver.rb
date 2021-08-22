class Exodriver < Formula
  desc "Thin interface to LabJack devices"
  homepage "https://labjack.com/support/linux-and-mac-os-x-drivers"
  url "https://github.com/labjack/exodriver/archive/v2.5.3.tar.gz"
  sha256 "24cae64bbbb29dc0ef13f482f065a14d075d2e975b7765abed91f1f8504ac2a5"
  head "https://github.com/labjack/exodriver.git"



  depends_on "libusb"

  def install
    system "make", "-C", "liblabjackusb", "install",
           "HEADER_DESTINATION=#{include}", "DESTINATION=#{lib}"
    ENV.prepend "CPPFLAGS", "-I#{include}"
    ENV.prepend "LDFLAGS", "-L#{lib}"
    system "make", "-C", "examples/Modbus"
    pkgshare.install "examples/Modbus/testModbusFunctions"
  end

  test do
    output = shell_output("#{pkgshare}/testModbusFunctions")
    assert_match /Result:\s+writeBuffer:/, output
  end
end
