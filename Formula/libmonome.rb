class Libmonome < Formula
  desc "Interact with monome devices via C, Python, or FFI"
  homepage "https://monome.org/"
  url "https://github.com/monome/libmonome/archive/v1.4.2.tar.gz"
  sha256 "d8f87fc8240214c2ca433f4b185eb3ddbace2065f95487e5d9ac0ab60220393d"
  head "https://github.com/monome/libmonome.git"



  depends_on "liblo"

  def install
    # Fix build on Mojave
    # https://github.com/monome/libmonome/issues/62
    inreplace "wscript", /conf.env.append_unique.*-mmacosx-version-min=10.5.*/,
                         "pass"

    system "./waf", "configure", "--prefix=#{prefix}"
    system "./waf", "build"
    system "./waf", "install"
  end
end
