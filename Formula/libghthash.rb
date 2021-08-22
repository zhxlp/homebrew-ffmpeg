class Libghthash < Formula
  desc "Generic hash table for C++"
  homepage "https://web.archive.org/web/20170824230514/www.bth.se/people/ska/sim_home/libghthash.html"
  url "https://web.archive.org/web/20170824230514/www.bth.se/people/ska/sim_home/filer/libghthash-0.6.2.tar.gz"
  mirror "https://pkg.freebsd.org/ports-distfiles/libghthash-0.6.2.tar.gz"
  sha256 "d1ccbb81f4c8afd7008f56ecb874f5cf497de480f49ee06929b4303d5852a7dd"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "autoreconf", "-ivf"
    system "./configure", "--disable-dependency-tracking",
           "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <string.h>
      #include <stdio.h>
      #include <stdlib.h>
      #include <ght_hash_table.h>

      int main(int argc, char *argv[])
      {
        ght_hash_table_t *p_table;
        int *p_data;
        int *p_he;
        int result;

        p_table = ght_create(128);

        if ( !(p_data = (int*)malloc(sizeof(int))) ) {
          return 1;
        }

        *p_data = 15;

        ght_insert(p_table,
             p_data,
             sizeof(char)*strlen("blabla"), "blabla");

        if ( (p_he = ght_get(p_table,
                 sizeof(char)*strlen("blabla"), "blabla")) ) {
          result = 0;
        } else {
          result = 1;
        }
        ght_finalize(p_table);

        return result;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lghthash", "-o", "test"
    system "./test"
  end
end
