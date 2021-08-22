class Wdc < Formula
  desc "WebDAV Client provides easy and convenient to work with WebDAV-servers"
  homepage "https://designerror.github.io/webdav-client-cpp"
  url "https://github.com/designerror/webdav-client-cpp/archive/v1.0.1.tar.gz"
  sha256 "64b01de188032cb9e09f5060965bd90ed264e7c0b4ceb62bfc036d0caec9fd82"



  depends_on "cmake" => :build
  depends_on "openssl"
  depends_on "pugixml"

  def install
    pugixml = Formula["pugixml"]
    ENV.prepend "CXXFLAGS", "-I#{pugixml.opt_include.children.first}"
    system "cmake", ".", "-DPUGIXML_INCLUDE_DIR=#{pugixml.opt_include}",
                         "-DPUGIXML_LIBRARY=#{pugixml.opt_lib}", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <webdav/client.hpp>
      #include <cassert>
      #include <string>
      #include <memory>
      #include <map>
      int main(int argc, char *argv[]) {
        std::map<std::string, std::string> options =
        {
          {"webdav_hostname", "https://webdav.example.com"},
          {"webdav_login",    "webdav_login"},
          {"webdav_password", "webdav_password"}
        };
        std::shared_ptr<WebDAV::Client> client(WebDAV::Client::Init(options));
        auto check_connection = client->check();
        assert(!check_connection);
      }
    EOS
    pugixml = Formula["pugixml"]
    openssl = Formula["openssl"]
    system ENV.cc, "test.cpp", "-o", "test", "-lcurl", "-lstdc++", "-std=c++11",
                   "-L#{lib}", "-lwdc", "-I#{include}",
                   "-L#{openssl.opt_lib}", "-lssl", "-lcrypto",
                   "-I#{openssl.opt_include}",
                   "-L#{Dir["#{pugixml.opt_lib}/pug*"].first}", "-lpugixml",
                   "-I#{pugixml.opt_include.children.first}"
    system "./test"
  end
end
