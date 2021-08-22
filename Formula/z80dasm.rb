class Z80dasm < Formula
  desc "Disassembler for the Zilog Z80 microprocessor and compatibles"
  homepage "https://www.tablix.org/~avian/blog/articles/z80dasm/"
  url "https://www.tablix.org/~avian/z80dasm/z80dasm-1.1.5.tar.gz"
  sha256 "91ecbfa43e5a9c15665560668fb1a9e3f0455f28a6f7478450bd61ff56d6b96e"



  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    path = testpath/"a.bin"
    path.binwrite [0xcd, 0x34, 0x12].pack("c*")
    assert_match /call 01234h/, shell_output("#{bin}/z80dasm #{path}")
  end
end
