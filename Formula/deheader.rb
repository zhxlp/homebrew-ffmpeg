class Deheader < Formula
  desc "Analyze C/C++ files for unnecessary headers"
  homepage "http://www.catb.org/~esr/deheader"
  url "http://www.catb.org/~esr/deheader/deheader-1.6.tar.gz",
      :using => :nounzip
  sha256 "3b99665c4f0dfda31d200bf2528540d6898cb846499ee91effa2e8f72aff3a60"
  head "https://gitlab.com/esr/deheader.git"



  depends_on "xmlto" => :build

  def install
    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"

    # Remove for > 1.6
    # Fix "deheader-1.6/deheader.1: Can't create 'deheader-1.6/deheader.1'"
    # See https://gitlab.com/esr/deheader/commit/ea5d8d4
    system "/usr/bin/tar", "-xvqf", "deheader-1.6.tar.gz",
                           "deheader-1.6/deheader.1"
    system "/usr/bin/tar", "-xvf", "deheader-1.6.tar.gz", "--exclude",
                           "deheader-1.6/deheader.1"
    cd "deheader-1.6" do
      system "make"
      bin.install "deheader"
      man1.install "deheader.1"
    end
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <string.h>
      int main(void) {
        printf("%s", "foo");
        return 0;
      }
    EOS
    assert_equal "121", shell_output("#{bin}/deheader test.c | tr -cd 0-9")
  end
end
