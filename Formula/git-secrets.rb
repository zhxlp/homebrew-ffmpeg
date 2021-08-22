class GitSecrets < Formula
  desc "Prevents you from committing sensitive information to a git repo"
  homepage "https://github.com/awslabs/git-secrets"
  url "https://github.com/awslabs/git-secrets/archive/1.2.1.tar.gz"
  sha256 "9899907609b227e495725af7cf094cf9e09a8d732945db24ef5558fd0d6ad5ef"
  head "https://github.com/awslabs/git-secrets.git"



  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "git", "init"
    system "git", "secrets", "--install"
  end
end
