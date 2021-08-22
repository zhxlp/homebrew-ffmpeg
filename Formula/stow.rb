class Stow < Formula
  desc "Organize software neatly under a single directory tree (e.g. /usr/local)"
  homepage "https://www.gnu.org/software/stow/"
  url "https://ftp.gnu.org/gnu/stow/stow-2.2.2.tar.gz"
  mirror "https://ftpmirror.gnu.org/stow/stow-2.2.2.tar.gz"
  sha256 "e2f77649301b215b9adbc2f074523bedebad366812690b9dc94457af5cf273df"



  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test").mkpath
    system "#{bin}/stow", "-nvS", "test"
  end
end
