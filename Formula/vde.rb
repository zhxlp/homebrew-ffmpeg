class Vde < Formula
  desc "Ethernet compliant virtual network"
  homepage "https://vde.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/vde/vde2/2.3.2/vde2-2.3.2.tar.gz"
  sha256 "22df546a63dac88320d35d61b7833bbbcbef13529ad009c7ce3c5cb32250af93"



  def install
    system "./configure", "--prefix=#{prefix}"
    # 2.3.1 built in parallel but 2.3.2 does not. See:
    # https://sourceforge.net/p/vde/bugs/54/
    ENV.deparallelize
    system "make", "install"
  end
end
