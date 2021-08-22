class Srclib < Formula
  desc "Polyglot code analysis library, built for hackability"
  homepage "https://srclib.org"
  url "https://github.com/sourcegraph/srclib/archive/v0.2.5.tar.gz"
  sha256 "f410dc87edb44bf10ce8ebd22d0b3c20b9a48fd3186ae38227380be04580574a"
  head "https://github.com/sourcegraph/srclib.git"



  depends_on "go" => :build
  depends_on "godep" => :build

  def install
    ENV["GOBIN"] = bin
    ENV["GOPATH"] = buildpath
    (buildpath/"src/sourcegraph.com/sourcegraph/srclib").install buildpath.children

    cd "src/sourcegraph.com/sourcegraph/srclib" do
      system "godep", "restore"
      system "go", "build", "-o", bin/"srclib", "./cmd/srclib"
      prefix.install_metafiles
    end
  end

  test do
    system "#{bin}/srclib", "info"
  end
end
