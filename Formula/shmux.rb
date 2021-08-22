class Shmux < Formula
  desc "Execute the same command on many hosts in parallel"
  homepage "https://github.com/shmux/shmux"
  url "https://github.com/shmux/shmux/archive/v1.0.2.tar.gz"
  sha256 "4b84dc3e0d72d054ed4730d130a509f43441fb61561c11a444d6ee65cbff9c04"



  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/shmux", "-h"
  end
end
