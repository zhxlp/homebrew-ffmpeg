class RabbitmqC < Formula
  desc "RabbitMQ C client"
  homepage "https://github.com/alanxz/rabbitmq-c"
  url "https://github.com/alanxz/rabbitmq-c/archive/v0.9.0.tar.gz"
  sha256 "316c0d156452b488124806911a62e0c2aa8a546d38fc8324719cd29aaa493024"
  head "https://github.com/alanxz/rabbitmq-c.git"



  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "openssl"
  depends_on "popt"

  def install
    system "cmake", ".", *std_cmake_args, "-DBUILD_EXAMPLES=OFF",
                         "-DBUILD_TESTS=OFF", "-DBUILD_API_DOCS=OFF",
                         "-DBUILD_TOOLS=ON"
    system "make", "install"
  end

  test do
    system bin/"amqp-get", "--help"
  end
end
