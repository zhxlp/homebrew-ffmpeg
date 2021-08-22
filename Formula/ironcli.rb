class Ironcli < Formula
  desc "Go version of the Iron.io command-line tools"
  homepage "https://github.com/iron-io/ironcli"
  url "https://github.com/iron-io/ironcli/archive/0.1.6.tar.gz"
  sha256 "2b9e65c36e4f57ccb47449d55adc220d1c8d1c0ad7316b6afaf87c8d393caae6"



  depends_on "dep" => :build
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/iron-io/ironcli").install buildpath.children
    cd "src/github.com/iron-io/ironcli" do
      system "dep", "ensure", "-vendor-only"
      system "go", "build", "-o", bin/"iron"
      prefix.install_metafiles
    end
  end

  test do
    system bin/"iron", "-help"
  end
end
