class Ppl < Formula
  desc "Parma Polyhedra Library: numerical abstractions for analysis, verification"
  homepage "https://bugseng.com/ppl"
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/p/ppl/ppl_1.2.orig.tar.xz"
  mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/p/ppl/ppl_1.2.orig.tar.xz"
  sha256 "691f0d5a4fb0e206f4e132fc9132c71d6e33cdda168470d40ac3cf62340e9a60"



  depends_on "gmp"

  # Fix compilation with Xcode 10
  # Upstream commit, remove for next version
  patch do
    url "http://www.cs.unipr.it/git/gitweb.cgi?p=ppl/ppl.git;a=commitdiff_plain;h=c39f6a07b51f89e365b05ba4147aa2aa448febd7"
    sha256 "6786f432784b74b81805b1d97e97cd1cc9f68653077681bb4f531466cbf8dc99"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--with-gmp=#{Formula["gmp"].opt_prefix}",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <ppl_c.h>
      #ifndef PPL_VERSION_MAJOR
      #error "No PPL header"
      #endif
      int main() {
        ppl_initialize();
        return ppl_finalize();
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lppl_c", "-lppl", "-o", "test"
    system "./test"
  end
end
