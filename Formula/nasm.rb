class Nasm < Formula
  desc "Netwide Assembler (NASM) is an 80x86 assembler"
  homepage "https://www.nasm.us/"
  url "https://www.nasm.us/pub/nasm/releasebuilds/2.14.02/nasm-2.14.02.tar.xz"
  sha256 "e24ade3e928f7253aa8c14aa44726d1edf3f98643f87c9d72ec1df44b26be8f5"



  head do
    url "https://repo.or.cz/nasm.git"
    depends_on "asciidoc" => :build
    depends_on "autoconf" => :build
    depends_on "xmlto" => :build
  end

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--prefix=#{prefix}"
    system "make", "manpages" if build.head?
    system "make", "rdf"
    system "make", "install", "install_rdf"
  end

  test do
    (testpath/"foo.s").write <<~EOS
      mov eax, 0
      mov ebx, 0
      int 0x80
    EOS

    system "#{bin}/nasm", "foo.s"
    code = File.open("foo", "rb") { |f| f.read.unpack("C*") }
    expected = [0x66, 0xb8, 0x00, 0x00, 0x00, 0x00, 0x66, 0xbb,
                0x00, 0x00, 0x00, 0x00, 0xcd, 0x80]
    assert_equal expected, code
  end
end
