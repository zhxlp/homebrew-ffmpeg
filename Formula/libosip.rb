class Libosip < Formula
  desc "Implementation of the eXosip2 stack"
  homepage "https://www.gnu.org/software/osip/"
  url "https://ftp.gnu.org/gnu/osip/libosip2-5.0.0.tar.gz"
  mirror "https://ftpmirror.gnu.org/osip/libosip2-5.0.0.tar.gz"
  sha256 "18a13c954f7297978e7bf1a0cdadde7c531e519d61a045dae304e054f3b2df03"



  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
