class Xtail < Formula
  desc "Watch growth of multiple files or directories (like `tail -f`)"
  homepage "https://www.unicom.com/sw/xtail"
  url "https://www.unicom.com/files/xtail-2.1.tar.gz"
  sha256 "75184926dffd89e9405769b24f01c8ed3b25d3c4a8eac60271fc5bb11f6c2d53"



  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    man1.mkpath
    bin.mkpath
    system "make", "install"
  end

  test do
    file1 = testpath/"file1"
    file2 = testpath/"file2"
    touch file1
    touch file2

    begin
      p = IO.popen("#{bin}/xtail file1 file2")
      # Give xtail a couple seconds before and after so that it could
      # relatively reliably pick up the changes.
      sleep 2
      file1.append_lines "hello\n"
      file2.append_lines "world\n"
      sleep 2
    ensure
      Process.kill "QUIT", p.pid
      Process.wait p.pid
    end

    output = p.read
    assert_match "hello", output
    assert_match "world", output
  end
end
