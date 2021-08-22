class LibxmpLite < Formula
  desc "Lite libxmp"
  homepage "https://xmp.sourceforge.io"
  url "https://downloads.sourceforge.net/project/xmp/libxmp/4.4.1/libxmp-lite-4.4.1.tar.gz"
  sha256 "bce9cbdaa19234e08e62660c19ed9a190134262066e7f8c323ea8ad2ac20dc39"



  # Remove for > 4.4.1
  # Fix build failure "dyld: Symbol not found: _it_loader"
  # Upstream commit "libxmp-lite building (wrong format loaders)"
  # Already in master. Original PR 6 Nov 2016 https://github.com/cmatsuoka/libxmp/pull/82
  patch :p2 do
    url "https://github.com/cmatsuoka/libxmp/commit/a028835.patch?full_index=1"
    sha256 "74b8689dcc23943168c6ae6afbda94dbcca78d08caae860b31ff573610ec5f92"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~'EOS'
      #include <stdio.h>
      #include <libxmp-lite/xmp.h>

      int main(int argc, char* argv[]){
        printf("libxmp-lite %s/%c%u\n", XMP_VERSION, *xmp_version, xmp_vercode);
        return 0;
      }
    EOS

    system ENV.cc, "-I", include, "-L", lib, "-L#{lib}", "-lxmp-lite", "test.c", "-o", "test"
    system "#{testpath}/test"
  end
end
