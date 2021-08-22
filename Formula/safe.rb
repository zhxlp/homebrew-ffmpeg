class Safe < Formula
  desc "Command-line interface for Vault"
  homepage "https://github.com/starkandwayne/safe"
  url "https://github.com/starkandwayne/safe/archive/v1.1.0.tar.gz"
  sha256 "fc72d88f3eac0ce2105fe99c1bdbfec211609b1bce1c032cd268617c4bd484a2"



  depends_on "go" => :build
  depends_on "vault"

  def install
    ENV["GOPATH"] = buildpath
    ENV["VERSION"] = version

    (buildpath/"src/github.com/starkandwayne/safe").install buildpath.children

    cd "src/github.com/starkandwayne/safe" do
      system "make", "build"
      bin.install "safe"
      prefix.install_metafiles
    end
  end

  test do
    require "yaml"

    pid = fork { exec "#{bin}/safe", "local", "--memory" }
    sleep 1
    handshake_yaml = Utils.popen_read("#{bin}/safe", "get", "secret/handshake")
    Process.kill("TERM", pid)

    parsed = YAML.safe_load(handshake_yaml)
    assert_equal "knock", parsed["knock"]
  end
end
