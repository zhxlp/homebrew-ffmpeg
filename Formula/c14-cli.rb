class C14Cli < Formula
  desc "Manage your Online C14 archives from the command-line"
  homepage "https://github.com/online-net/c14-cli"
  url "https://github.com/online-net/c14-cli/archive/0.3.tar.gz"
  sha256 "d4a2e839394cb5f169bfb3be0102569a310dd7315aba3cdb1dfcd9d9c6e43543"
  head "https://github.com/online-net/c14-cli.git"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    (buildpath/"src/github.com/online-net/c14-cli").install Dir["*"]

    system "go", "build", "-ldflags",
           "-X  github.com/online-net/c14-cli/pkg/version.GITCOMMIT=homebrew",
           "-o", bin/"c14", "github.com/online-net/c14-cli/cmd/c14/"
  end

  test do
    output = shell_output(bin/"c14 help")
    assert_match "Interact with C14 from the command line.", output
  end
end
