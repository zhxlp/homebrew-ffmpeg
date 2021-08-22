class Deisctl < Formula
  desc "Deis Control Utility"
  homepage "https://deis.io/"
  url "https://github.com/deis/deis/archive/v1.13.4.tar.gz"
  sha256 "7f1b378d884d5b42d0b03df7c79aa31cc6081bcc4c23d880101e98fdfe7cb89a"



  depends_on "go" => :build
  depends_on "godep" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/deis").mkpath
    ln_s buildpath, "src/github.com/deis/deis"
    system "godep", "restore"
    system "go", "build", "-o", bin/"deisctl", "deisctl/deisctl.go"
  end

  test do
    system bin/"deisctl", "help"
  end
end
