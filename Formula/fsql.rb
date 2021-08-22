class Fsql < Formula
  desc "Search through your filesystem with SQL-esque queries"
  homepage "https://github.com/kshvmdn/fsql"
  url "https://github.com/kshvmdn/fsql/archive/v0.3.1.tar.gz"
  sha256 "b88110426a60aa2c48f7b4e52e117a899d43d1bba2614346b729234cd4bd9184"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/kshvmdn").mkpath
    ln_s buildpath, buildpath/"src/github.com/kshvmdn/fsql"
    system "go", "build", "-o", bin/"fsql", "github.com/kshvmdn/fsql/cmd/fsql"
  end

  test do
    (testpath/"bar.txt").write("hello")
    (testpath/"foo/baz.txt").write("world")
    cmd = "#{bin}/fsql SELECT FULLPATH\\(name\\) FROM foo"
    assert_match %r{^foo\s+foo/baz.txt$}, shell_output(cmd)
    cmd = "#{bin}/fsql SELECT name FROM . WHERE name = bar.txt"
    assert_equal "bar.txt", shell_output(cmd).chomp
    cmd = "#{bin}/fsql SELECT name FROM . WHERE FORMAT\\(size\, GB\\) \\> 500"
    assert_equal "", shell_output(cmd)
  end
end
