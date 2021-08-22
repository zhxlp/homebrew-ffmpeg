class Stout < Formula
  desc "Reliable static website deploy tool"
  homepage "https://github.com/cloudflare/Stout"
  url "https://github.com/cloudflare/Stout/archive/v1.3.1.tar.gz"
  sha256 "455e238e238bf79f58d2e5a41f5ac582361c71a7eec72f45554f1c8f64de7006"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    mkdir_p buildpath/"src/github.com/cloudflare"
    ln_s buildpath, buildpath/"src/github.com/cloudflare/stout"
    system "go", "build", "-o", bin/"stout", "-v", "github.com/cloudflare/stout/src"
  end

  test do
    system "#{bin}/stout"
  end
end
