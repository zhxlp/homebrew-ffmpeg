class Liberasurecode < Formula
  desc "Erasure Code API library written in C with pluggable backends"
  homepage "https://github.com/openstack/liberasurecode"
  url "https://github.com/openstack/liberasurecode/archive/1.6.0.tar.gz"
  sha256 "37f36f49f302a47253c7756e13fd7d28028542efbad5acadbf432c1a55a7e085"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "jerasure"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"liberasurecode-test.cpp").write <<~EOS
      #include <erasurecode.h>

      int main() {
          /*
           * Assumes if you can create an erasurecode instance that
           * the library loads, relying on the library test suites
           * to test for correctness.
           */
          struct ec_args args = {
              .k  = 10,
              .m  = 5,
              .hd = 3
          };
          int ed = liberasurecode_instance_create(
                  EC_BACKEND_FLAT_XOR_HD,
                  &args
                  );

          if (ed <= 0) { exit(1); }
          liberasurecode_instance_destroy(ed);

          exit(0);
      }
    EOS
    system ENV.cxx, "liberasurecode-test.cpp", "-L#{lib}", "-lerasurecode", "-I#{include}/liberasurecode", "-o", "liberasurecode-test"
    system "./liberasurecode-test"
  end
end
