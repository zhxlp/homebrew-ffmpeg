class Mmix < Formula
  desc "64-bit RISC architecture designed by Donald Knuth"
  homepage "http://mmix.cs.hm.edu/"
  url "http://mmix.cs.hm.edu/src/mmix-20160804.tgz"
  sha256 "fad8e64fddf2d75cbcd5080616b47e11a2d292a428cdb0c12e579be680ecdee9"



  depends_on "cweb" => :build

  def install
    ENV.deparallelize
    system "make", "all"
    bin.install "mmix", "mmixal", "mmmix", "mmotype"
  end

  test do
    (testpath/"hello.mms").write <<~EOS
            LOC  Data_Segment
            GREG @
      txt   BYTE "Hello world!",0

            LOC #100

      Main  LDA $255,txt
            TRAP 0,Fputs,StdOut
            TRAP 0,Fputs,StdErr
            TRAP 0,Halt,0
    EOS
    system bin/"mmixal", "hello.mms"
    assert_equal "Hello world!", shell_output("#{bin}/mmix hello.mmo")
  end
end
