class GitSizer < Formula
  desc "Compute various size metrics for a Git repository"
  homepage "https://github.com/github/git-sizer"
  url "https://github.com/github/git-sizer/archive/v1.3.0.tar.gz"
  sha256 "c5f77d50eeda704a228f30f5a233ef0e56ef9f4cc83433d46e331b3247d28c6d"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/github/git-sizer").install buildpath.children
    cd "src/github.com/github/git-sizer" do
      system "go", "build", "-o", bin/"git-sizer"
      prefix.install_metafiles
    end
  end

  test do
    system "git", "init"
    output = shell_output("#{bin}/git-sizer")
    assert_match "No problems above the current threshold were found", output
  end
end
