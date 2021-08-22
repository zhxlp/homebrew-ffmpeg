class Netperf < Formula
  desc "Benchmarks performance of many different types of networking"
  homepage "https://hewlettpackard.github.io/netperf/"
  url "https://github.com/HewlettPackard/netperf/archive/netperf-2.7.0.tar.gz"
  sha256 "4569bafa4cca3d548eb96a486755af40bd9ceb6ab7c6abd81cc6aa4875007c4e"
  head "https://github.com/HewlettPackard/netperf.git"



  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/netperf -h | cat"
  end
end
