class Groff < Formula
  desc "GNU troff text-formatting system"
  homepage "https://www.gnu.org/software/groff/"
  url "https://ftp.gnu.org/gnu/groff/groff-1.22.4.tar.gz"
  mirror "https://ftpmirror.gnu.org/groff/groff-1.22.4.tar.gz"
  sha256 "e78e7b4cb7dec310849004fa88847c44701e8d133b5d4c13057d876c1bad0293"



  def install
    system "./configure", "--prefix=#{prefix}", "--without-x"
    system "make" # Separate steps required
    system "make", "install"
  end

  test do
    assert_match "homebrew\n",
      pipe_output("#{bin}/groff -a", "homebrew\n")
  end
end
