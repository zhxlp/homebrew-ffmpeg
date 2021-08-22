class Ne < Formula
  desc "The nice editor"
  homepage "http://ne.di.unimi.it/"
  url "https://github.com/vigna/ne/archive/3.1.2.tar.gz"
  sha256 "bdf09a377660527857bd25217fc91505ae2b19c41590f8a25efc91aef785a3e2"
  head "https://github.com/vigna/ne.git"



  depends_on "texinfo" => :build

  def install
    ENV.deparallelize
    cd "src" do
      system "make"
    end
    system "make", "build", "PREFIX=#{prefix}", "install"
  end

  test do
    ENV["TERM"] = "xterm"
    document = testpath/"test.txt"
    macros = testpath/"macros"
    document.write <<~EOS
      This is a test document.
    EOS
    macros.write <<~EOS
      GotoLine 2
      InsertString line 2
      InsertLine
      Exit
    EOS
    system "script", "-q", "/dev/null", bin/"ne", "--macro", macros, document
    assert_equal <<~EOS, document.read
      This is a test document.
      line 2
    EOS
  end
end
