class Ctop < Formula
  desc "Top-like interface for container metrics"
  homepage "https://bcicen.github.io/ctop/"
  url "https://github.com/bcicen/ctop/archive/v0.7.2.tar.gz"
  sha256 "bb40939b3d420864db6abc82e885a755f6de5b2e84eef3c7b956a8508f931811"



  depends_on "dep" => :build
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "on"
    (buildpath/"src/github.com/bcicen/ctop").install buildpath.children
    cd "src/github.com/bcicen/ctop" do
      system "make", "build"
      bin.install "ctop"
      prefix.install_metafiles
    end
  end

  test do
    system "#{bin}/ctop", "-v"
  end
end
