class Libpointing < Formula
  desc "Provides direct access to HID pointing devices"
  homepage "https://github.com/INRIA/libpointing"
  url "https://github.com/INRIA/libpointing/releases/download/v1.0.7/libpointing-mac-1.0.7.tar.gz"
  sha256 "29f12da75727d1b03ff952a2754ce79b88aec39b5e03a52d3b0ff7440f08f147"



  def install
    ENV.cxx11
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <pointing/pointing.h>
      #include <iostream>
      int main() {
        std::cout << LIBPOINTING_VER_STRING << " |" ;
        std::list<std::string> schemes = pointing::TransferFunction::schemes() ;
        for (std::list<std::string>::iterator i=schemes.begin(); i!=schemes.end(); ++i) {
          std::cout << " " << (*i) ;
        }
        std::cout << std::endl ;
        return 0;
      }
    EOS
    system ENV.cxx, "-std=c++11", "test.cpp", "-L#{lib}", "-lpointing", "-o", "test"
    system "./test"
  end
end
