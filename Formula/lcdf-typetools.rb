class LcdfTypetools < Formula
  desc "Manipulate OpenType and multiple-master fonts"
  homepage "https://www.lcdf.org/type/"
  url "https://www.lcdf.org/type/lcdf-typetools-2.107.tar.gz"
  sha256 "46be885f4623e2e595f786c70e03264b680066de57789833db541f947a8edfdb"



  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--without-kpathsea"
    system "make", "install"
  end

  test do
    assert_match "STIXGeneral-Regular",
      shell_output("#{bin}/otfinfo -p /Library/Fonts/STIXGeneral.otf")
  end
end
