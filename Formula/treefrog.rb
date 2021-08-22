class Treefrog < Formula
  desc "High-speed C++ MVC Framework for Web Application"
  homepage "http://www.treefrogframework.org/"
  url "https://github.com/treefrogframework/treefrog-framework/archive/v1.22.0.tar.gz"
  sha256 "0b9d79d0e17266ff603c1ff812289e8d2500d8f758d3c700ccc3aaad51e3751d"
  head "https://github.com/treefrogframework/treefrog-framework.git"



  depends_on :xcode => ["8.0", :build]
  depends_on :macos => :el_capitan
  depends_on "qt"

  def install
    system "./configure", "--prefix=#{prefix}"

    cd "src" do
      system "make"
      system "make", "install"
    end

    cd "tools" do
      system "make"
      system "make", "install"
    end
  end

  test do
    system bin/"tspawn", "new", "hello"
    assert_predicate testpath/"hello", :exist?
    cd "hello" do
      assert_predicate Pathname.pwd/"hello.pro", :exist?
      system HOMEBREW_PREFIX/"opt/qt/bin/qmake"
      assert_predicate Pathname.pwd/"Makefile", :exist?
      system "make"
      system bin/"treefrog", "-v"
    end
  end
end
