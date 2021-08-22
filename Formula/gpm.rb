class Gpm < Formula
  desc "Barebones dependency manager for Go"
  homepage "https://github.com/pote/gpm"
  url "https://github.com/pote/gpm/archive/v1.4.0.tar.gz"
  sha256 "2e213abbb1a12ecb895c3f02b74077d3440b7ae3221b4b524659c2ea9065b02a"
  revision 1



  depends_on "go"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    ENV["GOPATH"] = testpath
    (testpath/"Godeps").write("github.com/pote/gpm-testing-package v6.1")
    system bin/"gpm", "install"
    (testpath/"go_code.go").write <<~EOS
      package main
      import ("fmt"; "github.com/pote/gpm-testing-package")
      func main() { fmt.Print(gpm_testing_package.Version()) }
    EOS
    assert_equal "v6.1", shell_output("go run go_code.go")
  end
end
