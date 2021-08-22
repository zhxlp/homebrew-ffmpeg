class Poco < Formula
  desc "C++ class libraries for building network and internet-based applications"
  homepage "https://pocoproject.org/"
  url "https://pocoproject.org/releases/poco-1.9.0/poco-1.9.0-all.tar.gz"
  sha256 "0387bf0f9d313e2311742e1ad0b64e07f2f3e76039eed20e3b9aa9951b88e187"
  revision 1
  head "https://github.com/pocoproject/poco.git", :branch => "develop"



  depends_on "cmake" => :build
  depends_on "openssl"

  def install
    ENV.cxx11

    mkdir "build" do
      system "cmake", "..", *std_cmake_args, "-DENABLE_DATA_MYSQL=OFF",
                            "-DENABLE_DATA_ODBC=OFF"
      system "make", "install"
    end
  end

  test do
    system bin/"cpspc", "-h"
  end
end
