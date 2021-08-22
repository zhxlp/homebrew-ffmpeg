class Ren < Formula
  desc "Rename multiple files in a directory"
  homepage "http://pdb.finkproject.org/pdb/package.php/ren"
  url "https://www.ibiblio.org/pub/Linux/utils/file/ren-1.0.tar.gz"
  sha256 "6ccf51b473f07b2f463430015f2e956b63b1d9e1d8493a51f4ebd70f8a8136c9"



  def install
    system "make"
    bin.install "ren"
    man1.install "ren.1"
  end

  test do
    touch "test1.foo"
    touch "test2.foo"
    system bin/"ren", "*.foo", "#1.bar"
    assert_predicate testpath/"test1.bar", :exist?
    assert_predicate testpath/"test2.bar", :exist?
    refute_predicate testpath/"test1.foo", :exist?
    refute_predicate testpath/"test2.foo", :exist?
  end
end
