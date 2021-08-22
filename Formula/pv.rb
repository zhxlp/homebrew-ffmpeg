class Pv < Formula
  desc "Monitor data's progress through a pipe"
  homepage "https://www.ivarch.com/programs/pv.shtml"
  url "https://www.ivarch.com/programs/sources/pv-1.6.6.tar.bz2"
  sha256 "608ef935f7a377e1439c181c4fc188d247da10d51a19ef79bcdee5043b0973f1"



  def install
    system "./configure", "--disable-debug", "--prefix=#{prefix}",
                          "--mandir=#{man}", "--disable-nls"
    system "make", "install"
  end

  test do
    progress = pipe_output("#{bin}/pv -ns 4 2>&1 >/dev/null", "beer")
    assert_equal "100", progress.strip
  end
end
