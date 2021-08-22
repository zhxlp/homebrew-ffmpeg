class Cflow < Formula
  desc "Generate call graphs from C code"
  homepage "https://www.gnu.org/software/cflow/"
  url "https://ftp.gnu.org/gnu/cflow/cflow-1.5.tar.bz2"
  mirror "https://ftpmirror.gnu.org/cflow/cflow-1.5.tar.bz2"
  sha256 "6fe40a106a9ffd6a5489938b939d4301c04fa28a09596294b4f787abca1c037b"



  def install
    system "./configure", "--prefix=#{prefix}",
                          "--infodir=#{info}",
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--with-lispdir=#{elisp}"
    system "make", "install"
  end

  test do
    (testpath/"whoami.c").write <<~EOS
      #include <pwd.h>
      #include <sys/types.h>
      #include <stdio.h>
      #include <stdlib.h>

      int
      who_am_i (void)
      {
        struct passwd *pw;
        char *user = NULL;

        pw = getpwuid (geteuid ());
        if (pw)
          user = pw->pw_name;
        else if ((user = getenv ("USER")) == NULL)
          {
            fprintf (stderr, "I don't know!\n");
            return 1;
          }
        printf ("%s\n", user);
        return 0;
      }

      int
      main (int argc, char **argv)
      {
        if (argc > 1)
          {
            fprintf (stderr, "usage: whoami\n");
            return 1;
          }
        return who_am_i ();
      }
    EOS

    assert_match /getpwuid()/, shell_output("#{bin}/cflow --main who_am_i #{testpath}/whoami.c")
  end
end
