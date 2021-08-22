class Libspnav < Formula
  desc "Client library for connecting to 3Dconnexion's 3D input devices"
  homepage "https://spacenav.sourceforge.io"
  url "https://downloads.sourceforge.net/project/spacenav/spacenav%20library%20%28SDK%29/libspnav%200.2.3/libspnav-0.2.3.tar.gz"
  sha256 "7ae4d7bb7f6a5dda28b487891e01accc856311440f582299760dace6ee5f1f93"



  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --disable-x11
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <spnav.h>

      int main() {
        bool connected = spnav_open() != -1;
        if (connected) spnav_close();
        return 0;
      }
    EOS
    system ENV.cc, "test.cpp", "-I#{include}", "-L#{lib}", "-lspnav", "-o", "test"
    system "./test"
  end
end
