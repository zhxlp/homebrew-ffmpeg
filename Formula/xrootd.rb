class Xrootd < Formula
  desc "High performance, scalable, fault-tolerant access to data"
  homepage "http://xrootd.org"
  url "http://xrootd.org/download/v4.8.3/xrootd-4.8.3.tar.gz"
  sha256 "9cd30a343758b8f50aea4916fa7bd37de3c37c5b670fe059ae77a8b2bbabf299"
  head "https://github.com/xrootd/xrootd.git"



  depends_on "cmake" => :build
  depends_on "openssl"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    system "#{bin}/xrootd", "-H"
  end
end
