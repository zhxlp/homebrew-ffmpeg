class Libswiftnav < Formula
  desc "C library implementing GNSS related functions and algorithms"
  homepage "https://github.com/swift-nav/libswiftnav-legacy"
  url "https://github.com/swift-nav/libswiftnav-legacy/archive/v0.21.tar.gz"
  sha256 "087c7264c0d0d735414f8bffbfa52ab44696c500ba14a43262d98d6aa093221f"



  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdlib.h>
      #include <stdio.h>
      #include <libswiftnav/edc.h>

      const u8 *test_data = (u8*)"123456789";

      int main() {
        u32 crc;

        crc = crc24q(test_data, 9, 0xB704CE);
        if (crc != 0x21CF02) {
          printf("libswiftnav CRC quick test failed: CRC of \\"123456789\\" with init value 0xB704CE should be 0x21CF02, not 0x%06X\\n", crc);
          exit(1);
        } else {
          printf("libswiftnav CRC quick test successful, CRC = 0x21CF02\\n");
          exit(0);
        }
      }
    EOS
    system ENV.cc, "-L", lib, "-lswiftnav", "-o", "test", "test.c"
    system "./test"
  end
end
