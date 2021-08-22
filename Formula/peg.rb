class Peg < Formula
  desc "Program to perform pattern matching on text"
  homepage "http://piumarta.com/software/peg/"
  url "http://piumarta.com/software/peg/peg-0.1.18.tar.gz"
  sha256 "20193bdd673fc7487a38937e297fff08aa73751b633a086ac28c3b34890f9084"



  def install
    system "make", "all"
    bin.install %w[peg leg]
    man1.install gzip("src/peg.1")
  end

  test do
    (testpath/"username.peg").write <<~EOS
      start <- "username"
    EOS

    system "#{bin}/peg", "-o", "username.c", "username.peg"

    assert_match /yymatchString\(yy, "username"\)/, File.read("username.c")
  end
end
