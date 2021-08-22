class Detox < Formula
  desc "Utility to replace problematic characters in filenames"
  homepage "https://detox.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/detox/detox/1.2.0/detox-1.2.0.tar.bz2"
  sha256 "abfad90ee7d3e0fc53ce3b9da3253f9a800cdd92e3f8cc12a19394a7b1dcdbf8"



  def install
    system "./configure", "--mandir=#{man}", "--prefix=#{prefix}"
    system "make"
    (prefix/"etc").mkpath
    pkgshare.mkpath
    system "make", "install"
  end

  test do
    (testpath/"rename this").write "foobar"

    assert_equal "rename this -> rename_this\n", shell_output("#{bin}/detox --dry-run rename\\ this")
  end
end
