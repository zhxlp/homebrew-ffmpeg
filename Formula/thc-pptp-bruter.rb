class ThcPptpBruter < Formula
  desc "Brute force program against PPTP VPN endpoints (TCP port 1723)"
  homepage "https://thc.org"
  url "https://freeworld.thc.org/releases/thc-pptp-bruter-0.1.4.tar.gz"
  mirror "https://dl.bintray.com/homebrew/mirror/thc-pptp-bruter-0.1.4.tar.gz"
  sha256 "baa05f398d325b490e3eb4cd0ffaf67a6ae306c968a7d8114267b0c088de6ee2"



  depends_on "openssl"

  def install
    # The function openpty() is defined in pty.h on Linux, but in util.h on macOS.
    # See https://groups.google.com/group/sage-devel/msg/97916255b631e3e5
    inreplace "src/pptp_bruter.c", "pty.h", "util.h"

    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/thc-pptp-bruter"
  end
end
