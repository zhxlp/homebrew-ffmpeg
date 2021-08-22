class Monax < Formula
  desc "Blockchain application platform CLI"
  homepage "https://github.com/monax/monax"
  url "https://github.com/monax/monax/archive/v0.18.0.tar.gz"
  sha256 "8ad3166e3ca76738c6542bd8b85dcef1643b68a3755abe3e0a7f3c9cdd027afb"
  revision 1
  version_scheme 1



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = bin
    (buildpath/"src/github.com/monax").mkpath
    ln_sf buildpath, buildpath/"src/github.com/monax/monax"
    system "go", "install", "github.com/monax/monax/cmd/monax"
  end

  test do
    system "#{bin}/monax", "version"
  end
end
