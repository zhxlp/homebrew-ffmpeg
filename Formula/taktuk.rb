class Taktuk < Formula
  desc "Deploy commands to (a potentially large set of) remote nodes"
  homepage "http://taktuk.gforge.inria.fr/"
  url "https://gforge.inria.fr/frs/download.php/file/37055/taktuk-3.7.7.tar.gz"
  sha256 "56a62cca92670674c194e4b59903e379ad0b1367cec78244641aa194e9fe893e"



  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    ENV.deparallelize
    system "make", "install"
  end

  test do
    system "#{bin}/taktuk", "quit"
  end
end
