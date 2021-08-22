class Ortp < Formula
  desc "Real-time transport protocol (RTP, RFC3550) library"
  homepage "https://www.linphone.org/technical-corner/ortp/overview"
  url "https://nongnu.askapache.com/linphone/ortp/sources/ortp-0.27.0.tar.gz"
  sha256 "eb61a833ab3ad80978d7007411240f46e9b2d1034373b9d9dfaac88c1b6ec0af"
  revision 4



  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "mbedtls"

  resource "bctoolbox" do
    url "https://github.com/BelledonneCommunications/bctoolbox/archive/0.6.0.tar.gz"
    sha256 "299dedcf8f1edea79964314504f0d24e97cdf24a289896fc09bc69c38eb9f9be"
  end

  def install
    resource("bctoolbox").stage do
      args = std_cmake_args + %W[
        -DCMAKE_INSTALL_PREFIX=#{libexec}
        -DENABLE_TESTS_COMPONENT=OFF
      ]
      system "cmake", ".", *args
      system "make", "install"
    end

    libbctoolbox = (libexec/"lib/libbctoolbox.dylib").readlink
    MachO::Tools.change_dylib_id("#{libexec}/lib/libbctoolbox.dylib",
                                 "#{libexec}/lib/#{libbctoolbox}")

    ENV.prepend_path "PKG_CONFIG_PATH", libexec/"lib/pkgconfig"

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include "ortp/logging.h"
      #include "ortp/rtpsession.h"
      #include "ortp/sessionset.h"
      int main()
      {
        ORTP_PUBLIC void ortp_init(void);
        return 0;
      }
    EOS
    system ENV.cc, "-I#{include}", "-L#{lib}", "-lortp",
           testpath/"test.c", "-o", "test"
    system "./test"
  end
end
