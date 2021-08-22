class PdflibLite < Formula
  desc "Subset of the functionality of PDFlib 7"
  homepage "https://www.pdflib.com/download/free-software/pdflib-lite-7/"
  url "https://dl.bintray.com/homebrew/mirror/pdflib-lite--7.0.5p3.tar.xz"
  mirror "https://fossies.org/linux/misc/old/PDFlib-Lite-7.0.5p3.tar.gz"
  mirror "https://www.pdflib.com/binaries/PDFlib/705/PDFlib-Lite-7.0.5p3.tar.gz"
  version "7.0.5p3"
  sha256 "e5fb30678165d28b2bf066f78d5f5787e73a2a28d4902b63e3e07ce1678616c9"



  def install
    # Without the following substitution, pdflib-lite runs into weird
    # build errors due to bad interactions with the TIFF headers.
    # This workaround comes from the MacPorts.org portfile for pdflib.
    ENV["CPPFLAGS"] = "-isystem#{prefix}"

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--without-java",
                          "--without-perl",
                          "--without-py",
                          "--without-tcl",
                          "--without-ruby"
    system "make"
    system "make", "install"
  end

  def caveats; <<~EOS
    pdflib-lite is not open source software; usage restrictions apply!
    Be sure to understand and obey the license terms, which can be found at:
    https://www.pdflib.com/download/free-software/pdflib-lite-7/pdflib-lite-licensing/
  EOS
  end
end
