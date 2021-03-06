class Traildb < Formula
  desc "Blazingly-fast database for log-structured data"
  homepage "http://traildb.io/"
  url "https://github.com/traildb/traildb/archive/0.6.tar.gz"
  sha256 "f73515fe56c547f861296cf8eecc98b8e8bf00d175ad9fb7f4b981ad7cf8b67c"



  depends_on "pkg-config" => :build
  depends_on "libarchive"

  resource "judy" do
    url "https://downloads.sourceforge.net/project/judy/judy/Judy-1.0.5/Judy-1.0.5.tar.gz"
    sha256 "d2704089f85fdb6f2cd7e77be21170ced4b4375c03ef1ad4cf1075bd414a63eb"
  end

  def install
    # We build judy as static library, so we don't need to install it
    # into the real prefix
    judyprefix = "#{buildpath}/resources/judy"

    resource("judy").stage do
      system "./configure", "--disable-debug", "--disable-dependency-tracking",
          "--disable-shared", "--prefix=#{judyprefix}"

      # Parallel build is broken
      ENV.deparallelize do
        system "make", "-j1", "install"
      end
    end

    ENV["PREFIX"] = prefix
    ENV.append "CFLAGS", "-I#{judyprefix}/include"
    ENV.append "LDFLAGS", "-L#{judyprefix}/lib"
    system "./waf", "configure", "install"
  end

  test do
    # Check that the library has been installed correctly
    (testpath/"test.c").write <<~EOS
      #include <traildb.h>
      #include <assert.h>
      int main() {
        const char *path = "test.tdb";
        const char *fields[] = {};
        tdb_cons* c1 = tdb_cons_init();
        assert(tdb_cons_open(c1, path, fields, 0) == 0);
        assert(tdb_cons_finalize(c1) == 0);
        tdb* t1 = tdb_init();
        assert(tdb_open(t1, path) == 0);
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-ltraildb", "-o", "test"
    system "./test"

    # Check that the provided tdb binary works correctly
    (testpath/"in.csv").write("1234 1234\n")
    system "#{bin}/tdb", "make", "-c", "-i", "in.csv", "--tdb-format", "pkg"
  end
end
