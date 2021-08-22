class Ohcount < Formula
  desc "Source code line counter"
  homepage "https://github.com/blackducksw/ohcount"
  url "https://github.com/blackducksw/ohcount/archive/v3.1.1.tar.gz"
  sha256 "4be27e54ac0fb5016fe2f09c2f54ec0139e67d9e2d9ee2e8569f8dfb4e56f59f"
  head "https://github.com/blackducksw/ohcount.git"



  depends_on "libmagic"
  depends_on "pcre"
  depends_on "ragel"

  def install
    system "./build", "ohcount"
    bin.install "bin/ohcount"
  end

  test do
    (testpath/"test.rb").write <<~EOS
      # comment
      puts
      puts
    EOS
    stats = shell_output("#{bin}/ohcount -i test.rb").lines.last
    assert_equal ["ruby", "2", "1", "33.3%"], stats.split[0..3]
  end
end
