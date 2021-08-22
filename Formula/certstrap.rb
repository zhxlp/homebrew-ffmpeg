class Certstrap < Formula
  desc "Tools to bootstrap CAs, certificate requests, and signed certificates"
  homepage "https://github.com/square/certstrap"
  url "https://github.com/square/certstrap/archive/v1.1.1.tar.gz"
  sha256 "412ba90a4a48d535682f3c7529191cd30cd7a731e57065dcf4242155cec49d5e"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/square").mkpath
    ln_s buildpath, "src/github.com/square/certstrap"
    system "go", "build", "-o", bin/"certstrap"
  end

  test do
    system "#{bin}/certstrap", "init", "--common-name", "Homebrew Test CA", "--passphrase", "beerformyhorses"
  end
end
