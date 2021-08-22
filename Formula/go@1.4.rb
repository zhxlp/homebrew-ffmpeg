class GoAT14 < Formula
  desc "Go programming environment (1.4)"
  homepage "https://golang.org"
  url "https://github.com/golang/go.git",
      :revision => "d76c7d5a31ffaba3134f16981abd5f891fa2d805"
  version "1.4.3-20170922"



  keg_only :versioned_formula

  resource "gotools" do
    url "https://go.googlesource.com/tools.git",
        :branch => "release-branch.go1.4"
  end

  def install
    ENV.refurbish_args

    cd "src" do
      ENV["GOROOT_FINAL"] = libexec
      ENV["GOOS"]         = "darwin"
      ENV["CGO_ENABLED"]  = "0"
      system "./make.bash", "--no-clean"
    end

    (buildpath/"pkg/obj").rmtree
    libexec.install Dir["*"]
    (bin/"go").write_env_script(libexec/"bin/go", :PATH => "#{libexec}/bin:$PATH")
    bin.install_symlink libexec/"bin/gofmt"

    ENV.prepend_path "PATH", libexec/"bin"
    ENV["GOPATH"] = buildpath
    (buildpath/"src/golang.org/x/tools").install resource("gotools")

    cd "src/golang.org/x/tools/cmd/godoc/" do
      system "go", "build"
      (libexec/"bin").install "godoc"
    end
    bin.install_symlink libexec/"bin/godoc"

    cd "src/golang.org/x/tools/cmd/vet/" do
      system "go", "build"
      # This is where Go puts vet natively; not in the bin.
      (libexec/"pkg/tool/darwin_amd64/").install "vet"
    end
  end

  test do
    (testpath/"hello.go").write <<~EOS
      package main
      import "fmt"
      func main() {
          fmt.Println("Hello World")
      }
    EOS
    # Run go fmt check for no errors then run the program.
    # This is a a bare minimum of go working as it uses fmt, build, and run.
    system "#{bin}/go", "fmt", "hello.go"
    assert_equal "Hello World\n", shell_output("#{bin}/go run hello.go")

    assert_predicate libexec/"bin/godoc", :exist?, "godoc does not exist!"
    assert_predicate libexec/"bin/godoc", :executable?, "godoc is not executable!"
    assert_predicate libexec/"pkg/tool/darwin_amd64/vet", :exist?, "vet does not exist!"
    assert_predicate libexec/"pkg/tool/darwin_amd64/vet", :executable?, "vet is not executable!"
  end
end
