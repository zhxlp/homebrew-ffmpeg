class CoreosCt < Formula
  desc "Convert a Container Linux Config into Ignition"
  homepage "https://coreos.com/os/docs/latest/configuration.html"
  url "https://github.com/coreos/container-linux-config-transpiler/archive/v0.9.0.tar.gz"
  sha256 "140c2a5bfd2562a069882e66c4aee01290417f35ef0db06e11e74b2ccf52de7f"



  depends_on "go" => :build

  def install
    system "make", "all", "VERSION=v#{version}"
    bin.install "./bin/ct"
  end

  test do
    (testpath/"input").write <<~EOS
      passwd:
        users:
          - name: core
            ssh_authorized_keys:
              - ssh-rsa mykey
    EOS
    output = shell_output("#{bin}/ct -pretty -in-file #{testpath}/input")
    assert_match /.*"sshAuthorizedKeys":\s*["ssh-rsa mykey"\s*].*/m, output.strip
  end
end
