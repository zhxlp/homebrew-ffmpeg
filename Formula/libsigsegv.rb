class Libsigsegv < Formula
  desc "Library for handling page faults in user mode"
  homepage "https://www.gnu.org/software/libsigsegv/"
  url "https://ftp.gnu.org/gnu/libsigsegv/libsigsegv-2.12.tar.gz"
  mirror "https://ftpmirror.gnu.org/libsigsegv/libsigsegv-2.12.tar.gz"
  sha256 "3ae1af359eebaa4ffc5896a1aee3568c052c99879316a1ab57f8fe1789c390b6"



  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-shared"
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    # Sourced from tests/efault1.c in tarball.
    (testpath/"test.c").write <<~EOS
      #include "sigsegv.h"

      #include <errno.h>
      #include <fcntl.h>
      #include <stdio.h>
      #include <stdlib.h>
      #include <unistd.h>

      const char *null_pointer = NULL;
      static int
      handler (void *fault_address, int serious)
      {
        abort ();
      }

      int
      main ()
      {
        if (open (null_pointer, O_RDONLY) != -1 || errno != EFAULT)
          {
            fprintf (stderr, "EFAULT not detected alone");
            exit (1);
          }

        if (sigsegv_install_handler (&handler) < 0)
          exit (2);

        if (open (null_pointer, O_RDONLY) != -1 || errno != EFAULT)
          {
            fprintf (stderr, "EFAULT not detected with handler");
            exit (1);
          }

        printf ("Test passed");
        return 0;
      }
    EOS

    system ENV.cc, "test.c", "-L#{lib}", "-lsigsegv", "-o", "test"
    assert_match /Test passed/, shell_output("./test")
  end
end
