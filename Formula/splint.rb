class Splint < Formula
  desc "Secure Programming Lint"
  homepage "https://sourceforge.net/projects/splint/"
  url "https://mirrorservice.org/sites/distfiles.macports.org/splint/splint-3.1.2.src.tgz"
  mirror "https://src.fedoraproject.org/repo/pkgs/splint/splint-3.1.2.src.tgz/25f47d70bd9c8bdddf6b03de5949c4fd/splint-3.1.2.src.tgz"
  sha256 "c78db643df663313e3fa9d565118391825dd937617819c6efc7966cdf444fb0a"



  # fix compiling error of osd.c
  patch :DATA

  def install
    ENV.deparallelize # build is not parallel-safe
    system "./configure", "--disable-debug",
                          "--prefix=#{prefix}",
                          "--infodir=#{info}",
                          "--mandir=#{man}"
    system "make"
    system "make", "install"
  end

  test do
    path = testpath/"test.c"
    path.write <<~EOS
      #include <stdio.h>
      int main()
      {
          char c;
          printf("%c", c);
          return 0;
      }
    EOS

    output = shell_output("#{bin}/splint #{path} 2>&1", 1)
    assert_match /5:18:\s+Variable c used before definition/, output
  end
end


__END__
diff --git a/src/osd.c b/src/osd.c
index ebe214a..4ba81d5 100644
--- a/src/osd.c
+++ b/src/osd.c
@@ -516,7 +516,7 @@ osd_getPid ()
 # if defined (WIN32) || defined (OS2) && defined (__IBMC__)
   int pid = _getpid ();
 # else
-  __pid_t pid = getpid ();
+  pid_t pid = getpid ();
 # endif

   return (int) pid;
