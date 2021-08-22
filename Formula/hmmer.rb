class Hmmer < Formula
  desc "Build profile HMMs and scan against sequence databases"
  homepage "http://hmmer.org/"
  url "http://eddylab.org/software/hmmer/hmmer-3.2.1.tar.gz"
  sha256 "a56129f9d786ec25265774519fc4e736bbc16e4076946dcbd7f2c16efc8e2b9c"



  def install
    system "./configure", "--prefix=#{prefix}"
    system "make" # Fix error: install: hmmalign: No such file or directory
    system "make", "install"
    doc.install "Userguide.pdf", "tutorial"
  end

  test do
    assert_match "PF00069.17", shell_output("#{bin}/hmmstat #{doc}/tutorial/Pkinase.hmm")
  end
end
