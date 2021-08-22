class Sparse < Formula
  desc "Static C code analysis tool"
  homepage "https://sparse.wiki.kernel.org/"
  url "https://www.kernel.org/pub/software/devel/sparse/dist/sparse-0.5.2.tar.xz"
  sha256 "4632b7b74af72214247f982f976ba44206933bab3a2717e09df166fb5b8abe7a"
  head "https://git.kernel.org/pub/scm/devel/sparse/sparse.git"



  def install
    inreplace "Makefile", /PREFIX=\$\(HOME\)/, "PREFIX=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.C").write("int main(int a) {return a;}\n")
    system "#{bin}/sparse", testpath/"test.C"
  end
end
