class Es < Formula
  desc "Extensible shell with first class functions, lexical scoping, and more"
  homepage "https://wryun.github.io/es-shell/"
  url "https://github.com/wryun/es-shell/releases/download/v0.9.1/es-0.9.1.tar.gz"
  sha256 "b0b41fce99b122a173a06b899a4d92e5bd3cc48b227b2736159f596a58fff4ba"
  revision 1



  def install
    system "./configure", "--prefix=#{prefix}", "--with-editline"
    system "make"

    bin.install "es"
    doc.install %w[CHANGES README trip.es examples]
    man1.install "doc/es.1"
  end

  test do
    system "#{bin}/es < #{doc}/trip.es"
  end
end
