class Lv2 < Formula
  desc "Portable plugin standard for audio systems"
  homepage "http://lv2plug.in"
  url "http://lv2plug.in/spec/lv2-1.14.0.tar.bz2"
  sha256 "b8052683894c04efd748c81b95dd065d274d4e856c8b9e58b7c3da3db4e71d32"



  def install
    system "./waf", "configure", "--prefix=#{prefix}", "--no-plugins", "--lv2dir=#{lib}"
    system "./waf", "build"
    system "./waf", "install"
  end
end
