class Biogeme < Formula
  desc "Maximum likelihood estimation of choice models"
  homepage "https://biogeme.epfl.ch/"
  url "https://biogeme.epfl.ch/distrib/biogeme-2.6a.tar.gz"
  sha256 "f6de0ea12f83ed183f31a41b9a56d1ec7226d2305549fb89ea7b1de8273ede49"
  revision 4



  depends_on "gtkmm3"
  depends_on "python"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"minimal.py").write <<~EOS
      from biogeme import *
      rowIterator('obsIter')
      BIOGEME_OBJECT.SIMULATE = Enumerate({'Test':1},'obsIter')
    EOS
    (testpath/"minimal.dat").write <<~EOS
      TEST
      1
    EOS
    system bin/"pythonbiogeme", "minimal", "minimal.dat"
  end
end
