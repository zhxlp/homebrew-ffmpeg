class SshCopyId < Formula
  desc "Add a public key to a remote machine's authorized_keys file"
  homepage "https://www.openssh.com/"
  url "https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-7.9p1.tar.gz"
  mirror "https://mirror.vdms.io/pub/OpenBSD/OpenSSH/portable/openssh-7.9p1.tar.gz"
  version "7.9p1"
  sha256 "6b4b3ba2253d84ed3771c8050728d597c91cfce898713beb7b64a305b6f11aad"
  head "https://github.com/openssh/openssh-portable.git"

  bottle :unneeded

  def install
    bin.install "contrib/ssh-copy-id"
    man1.install "contrib/ssh-copy-id.1"
  end

  test do
    output = shell_output("#{bin}/ssh-copy-id -h 2>&1", 1)
    assert_match "identity_file", output
  end
end
