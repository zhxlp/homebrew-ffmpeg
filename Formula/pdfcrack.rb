class Pdfcrack < Formula
  desc "PDF files password cracker"
  homepage "https://pdfcrack.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/pdfcrack/pdfcrack/pdfcrack-0.16/pdfcrack-0.16.tar.gz"
  sha256 "7865b203074ccfd5c612c8ce00c46ffcb4fabaa26154ce9304dfc668c7cb73ef"



  def install
    system "make", "all"
    bin.install "pdfcrack"
  end

  test do
    system "#{bin}/pdfcrack", "--version"
  end
end
