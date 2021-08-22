class Tcc < Formula
  desc "Tiny C compiler"
  homepage "https://bellard.org/tcc/"
  url "https://download.savannah.nongnu.org/releases/tinycc/tcc-0.9.27.tar.bz2"
  sha256 "de23af78fca90ce32dff2dd45b3432b2334740bb9bb7b05bf60fdbfc396ceb9c"
  revision 1



  def install
    args = %W[
      --prefix=#{prefix}
      --source-path=#{buildpath}
      --sysincludepaths=/usr/local/include:#{MacOS.sdk_path}/usr/include:{B}/include
      --enable-cross"
    ]

    ENV.deparallelize
    system "./configure", *args
    system "make", "MACOSX_DEPLOYMENT_TARGET=#{MacOS.version}"
    system "make", "install"
  end

  test do
    (testpath/"hello-c.c").write <<~EOS
      #include <stdio.h>
      int main()
      {
        puts("Hello, world!");
        return 0;
      }
    EOS
    assert_equal "Hello, world!\n", shell_output("#{bin}/tcc -run hello-c.c")
  end
end
