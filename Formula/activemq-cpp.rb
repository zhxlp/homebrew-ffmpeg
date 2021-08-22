class ActivemqCpp < Formula
  desc "C++ API for message brokers such as Apache ActiveMQ"
  homepage "https://activemq.apache.org/cms/index.html"
  url "https://archive.apache.org/dist/activemq/activemq-cpp/3.9.4/activemq-cpp-library-3.9.4-src.tar.bz2"
  sha256 "6505137fd4835a388b5ddecf6a96a62abd01b6d80f124e95dc2076127f4a84d3"



  depends_on "pkg-config" => :build
  depends_on "apr"
  depends_on "openssl"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/activemqcpp-config", "--version"
  end
end
