class GitSecret < Formula
  desc "Bash-tool to store the private data inside a git repo"
  homepage "https://sobolevn.github.io/git-secret/"
  head "https://github.com/sobolevn/git-secret.git"

  stable do
    url "https://github.com/sobolevn/git-secret/archive/v0.2.5.tar.gz"
    sha256 "02224b360ef560d1a41ae758d16ef2f2657af8424711d52443ca7ac01367ad29"
  end



  depends_on "gawk"
  depends_on "gnupg"

  def install
    system "make", "build"
    system "bash", "utils/install.sh", prefix
  end

  test do
    (testpath/"batch.gpg").write <<~EOS
      Key-Type: RSA
      Key-Length: 2048
      Subkey-Type: RSA
      Subkey-Length: 2048
      Name-Real: Testing
      Name-Email: testing@foo.bar
      Expire-Date: 1d
      %no-protection
      %commit
    EOS
    begin
      system Formula["gnupg"].opt_bin/"gpg", "--batch", "--gen-key", "batch.gpg"
      system "git", "init"
      system "git", "config", "user.email", "testing@foo.bar"
      system "git", "secret", "init"
      assert_match "testing@foo.bar added", shell_output("git secret tell -m")
      (testpath/"shh.txt").write "Top Secret"
      (testpath/".gitignore").append_lines "shh.txt"
      system "git", "secret", "add", "shh.txt"
      system "git", "secret", "hide"
      assert_predicate testpath/"shh.txt.secret", :exist?
    ensure
      system Formula["gnupg"].opt_bin/"gpgconf", "--kill", "gpg-agent"
    end
  end
end
