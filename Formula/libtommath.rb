class Libtommath < Formula
  desc "C library for number theoretic multiple-precision integers"
  homepage "https://www.libtom.net/LibTomMath/"
  url "https://github.com/libtom/libtommath/releases/download/v1.0.1/ltm-1.0.1.tar.xz"
  sha256 "47032fb39d698ce4cf9c9c462c198e6b08790ce8203ad1224086b9b978636c69"
  head "https://github.com/libtom/libtommath.git"



  def install
    ENV["DESTDIR"] = prefix

    system "make"
    system "make", "test_standalone"
    include.install Dir["tommath*.h"]
    lib.install "libtommath.a"
    pkgshare.install "test"
  end

  test do
    system pkgshare/"test"
  end
end
