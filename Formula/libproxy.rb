class Libproxy < Formula
  desc "Library that provides automatic proxy configuration management"
  homepage "https://libproxy.github.io/libproxy/"
  url "https://github.com/libproxy/libproxy/archive/0.4.15.tar.gz"
  sha256 "18f58b0a0043b6881774187427ead158d310127fc46a1c668ad6d207fb28b4e0"
  revision 1
  head "https://github.com/libproxy/libproxy.git"



  depends_on "cmake" => :build
  depends_on "python"

  def install
    args = std_cmake_args + %W[
      ..
      -DPYTHON3_SITEPKG_DIR=#{lib}/python2.7/site-packages
      -DWITH_PERL=OFF
      -DWITH_PYTHON2=OFF
    ]

    mkdir "build" do
      system "cmake", *args
      system "make", "install"
    end
  end

  test do
    assert_equal "direct://", pipe_output("#{bin}/proxy 127.0.0.1").chomp
  end
end
