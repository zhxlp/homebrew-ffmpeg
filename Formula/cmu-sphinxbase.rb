class CmuSphinxbase < Formula
  desc "Lightweight speech recognition engine for mobile devices"
  homepage "https://cmusphinx.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/cmusphinx/sphinxbase/0.8/sphinxbase-0.8.tar.gz"
  sha256 "55708944872bab1015b8ae07b379bf463764f469163a8fd114cbb16c5e486ca8"



  head do
    url "https://github.com/cmusphinx/sphinxbase.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
    depends_on "swig" => :build
  end

  depends_on "pkg-config" => :build
  # If these are found, they will be linked against and there is no configure
  # switch to turn them off.
  depends_on "libsamplerate"
  depends_on "libsndfile"

  def install
    if build.head?
      ENV["NOCONFIGURE"] = "yes"
      system "./autogen.sh"
    end
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include "cmd_ln.h"

      int main(int argc, char **argv) {
        cmd_ln_t *config = NULL;

        config = cmd_ln_init(NULL, NULL, TRUE,
          "-hello", "world", NULL);
        cmd_ln_free_r(config);
        return 0;
      }
    EOS
    system ENV.cxx, "-L#{lib}", "-lsphinxbase", "-I#{include}/sphinxbase", "test.cpp", "-o", "test"
    system "./test"
  end
end
