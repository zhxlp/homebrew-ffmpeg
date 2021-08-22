class Jid < Formula
  desc "Json incremental digger"
  homepage "https://github.com/simeji/jid"
  url "https://github.com/simeji/jid/archive/v0.7.3.tar.gz"
  sha256 "4565030bdf22f831007ecc214fbd14205855b3dff98f7acc8dc6e1f7a2591820"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "on"

    src = buildpath/"src/github.com/simeji/jid"
    src.install buildpath.children
    src.cd do
      system "go", "build", "-o", bin/"jid", "cmd/jid/jid.go"
      prefix.install_metafiles
    end
  end

  test do
    assert_match "jid version v#{version}", shell_output("#{bin}/jid --version")
  end
end
