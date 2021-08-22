class Mspdebug < Formula
  desc "Debugger for use with MSP430 MCUs"
  homepage "https://dlbeer.co.nz/mspdebug/"
  url "https://github.com/dlbeer/mspdebug/archive/v0.25.tar.gz"
  sha256 "347b5ae5d0ab0cddb54363b72abe482f9f5d6aedb8f230048de0ded28b7d1503"
  head "https://github.com/dlbeer/mspdebug.git"



  depends_on "hidapi"
  depends_on "libusb-compat"

  def install
    ENV.append_to_cflags "-I#{Formula["hidapi"].opt_include}/hidapi"
    system "make", "PREFIX=#{prefix}", "install"
  end

  def caveats; <<~EOS
    You may need to install a kernel extension if you're having trouble with
    RF2500-like devices such as the TI Launchpad:
      https://dlbeer.co.nz/mspdebug/faq.html#rf2500_osx
  EOS
  end

  test do
    system bin/"mspdebug", "--help"
  end
end
