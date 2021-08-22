class Scmpuff < Formula
  desc "Adds numbered shortcuts for common git commands"
  homepage "https://mroth.github.io/scmpuff/"
  url "https://github.com/mroth/scmpuff/archive/v0.2.1.tar.gz"
  sha256 "6855562be9788a0fcf69102546f3bf8ccac063086d28a9a3f1ab4947e9dd08e2"



  depends_on "go" => :build

  def install
    mkdir_p buildpath/"src/github.com/mroth"
    ln_s buildpath, buildpath/"src/github.com/mroth/scmpuff"
    ENV["GOPATH"] = buildpath

    # scmpuff's build script normally does version detection which depends on
    # being checked out via git repo -- instead have homebrew specify version.
    system "go", "build", "-o", "#{bin}/scmpuff", "-ldflags", "-X main.VERSION=#{version}", "./src/github.com/mroth/scmpuff"
  end

  test do
    ENV["e1"] = "abc"
    assert_equal "abc", shell_output("#{bin}/scmpuff expand 1").strip
  end
end
