class Tbox < Formula
  desc "Glib-like multi-platform c library"
  homepage "https://tboox.org/"
  url "https://github.com/waruqi/tbox/archive/v1.6.3.tar.gz"
  sha256 "1ea225195ad6d41a29389137683fee7a853fa42f3292226ddcb6d6d862f5b33c"
  head "https://github.com/waruqi/tbox.git"



  depends_on "xmake" => :build

  def install
    system "xmake", "config", "--charset=y", "--demo=n", "--small=y", "--xml=y"
    system "xmake", "install", "-o", prefix
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <tbox/tbox.h>
      int main()
      {
        if (tb_init(tb_null, tb_null))
        {
          tb_trace_i("hello tbox!");
          tb_exit();
        }
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-ltbox", "-I#{include}", "-o", "test"
    system "./test"
  end
end
