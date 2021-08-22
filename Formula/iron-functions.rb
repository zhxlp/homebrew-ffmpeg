class IronFunctions < Formula
  desc "Go version of the IronFunctions command-line tools"
  homepage "https://github.com/iron-io/functions"
  url "https://github.com/iron-io/functions/archive/0.2.72.tar.gz"
  sha256 "8022db6eb7354003810bdb98250d4c2931dacb527dd1a5369686c9674b5ef649"



  depends_on "dep" => :build
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    dir = buildpath/"src/github.com/iron-io/functions"
    dir.install Dir["*"]
    cd dir/"fn" do
      system "make", "dep"
      system "go", "build", "-o", bin/"fn"
      prefix.install_metafiles
    end
  end

  test do
    expected = <<~EOS
      runtime: go
      func.yaml created.
    EOS
    output = shell_output("#{bin}/fn init --runtime go user/some 2>&1")
    assert_equal expected, output
  end
end
