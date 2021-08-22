class IcarusVerilog < Formula
  desc "Verilog simulation and synthesis tool"
  homepage "http://iverilog.icarus.com/"
  url "ftp://icarus.com/pub/eda/verilog/v10/verilog-10.2.tar.gz"
  mirror "https://deb.debian.org/debian/pool/main/i/iverilog/iverilog_10.2.orig.tar.gz"
  sha256 "96dedbddb12d375edb45a144a926a3ba1e3e138d6598b18e7d79f2ae6de9e500"
  revision 1



  head do
    url "https://github.com/steveicarus/iverilog.git"
    depends_on "autoconf" => :build
  end

  # parser is subtly broken when processed with an old version of bison
  depends_on "bison" => :build

  def install
    system "autoconf" if build.head?
    system "./configure", "--prefix=#{prefix}"
    # https://github.com/steveicarus/iverilog/issues/85
    ENV.deparallelize
    system "make", "install", "BISON=#{Formula["bison"].opt_bin}/bison"
  end

  test do
    (testpath/"test.v").write <<~EOS
      module main;
        initial
          begin
            $display("Boop");
            $finish;
          end
      endmodule
    EOS
    system bin/"iverilog", "-otest", "test.v"
    assert_equal "Boop", shell_output("./test").chomp

    # test syntax errors do not cause segfaults
    (testpath/"error.v").write "error;"
    assert_equal "-:1: error: variable declarations must be contained within a module.",
      shell_output("#{bin}/iverilog error.v 2>&1", 1).chomp
  end
end
