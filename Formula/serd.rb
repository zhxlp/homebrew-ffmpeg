class Serd < Formula
  desc "C library for RDF syntax"
  homepage "https://drobilla.net/software/serd/"
  url "https://download.drobilla.net/serd-0.28.0.tar.bz2"
  sha256 "1df21a8874d256a9f3d51a18b8c6e2539e8092b62cc2674b110307e93f898aec"



  depends_on "pkg-config" => :build

  def install
    system "./waf", "configure", "--prefix=#{prefix}"
    system "./waf"
    system "./waf", "install"
  end
end
