class Konoha < Formula
  desc "Static scripting language with extensible syntax"
  homepage "https://github.com/konoha-project/konoha3"
  url "https://github.com/konoha-project/konoha3/archive/v0.1.tar.gz"
  sha256 "e7d222808029515fe229b0ce1c4e84d0a35b59fce8603124a8df1aeba06114d3"
  revision 5



  head do
    url "https://github.com/konoha-project/konoha3.git"

    depends_on "openssl"
  end

  depends_on "cmake" => :build
  depends_on "json-c"
  depends_on "mecab"
  depends_on "open-mpi"
  depends_on "pcre"
  depends_on "python"
  depends_on "sqlite"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
  end

  test do
    (testpath/"test").write "System.p(\"Hello World!\");"
    output = shell_output("#{bin}/konoha #{testpath}/test")
    assert_match "(test:1) Hello World!", output
  end
end
