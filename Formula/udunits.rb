class Udunits < Formula
  desc "Unidata unit conversion library"
  homepage "https://www.unidata.ucar.edu/software/udunits/"
  url "ftp://ftp.unidata.ucar.edu/pub/udunits/udunits-2.2.26.tar.gz"
  mirror "https://fossies.org/linux/privat/udunits-2.2.26.tar.gz"
  sha256 "368f4869c9c7d50d2920fa8c58654124e9ed0d8d2a8c714a9d7fdadc08c7356d"



  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match(/1 kg = 1000 g/, shell_output("#{bin}/udunits2 -H kg -W g"))
  end
end
