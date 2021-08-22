class GithubMarkdownToc < Formula
  desc "Easy TOC creation for GitHub README.md (in go)"
  homepage "https://github.com/ekalinin/github-markdown-toc.go"
  url "https://github.com/ekalinin/github-markdown-toc.go/archive/1.0.0.tar.gz"
  sha256 "0a13627a29114ee817160ecd3eba130c05f95c4aeedb9d0805d8b5a587fce55a"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "on"
    dir = buildpath/"src/github.com/ekalinin/github-markdown-toc.go"
    dir.install buildpath.children
    cd dir do
      system "go", "build", "-o", bin/"gh-md-toc"
      prefix.install_metafiles
    end
  end

  test do
    (testpath/"README.md").write("# Header")
    system bin/"gh-md-toc", "--version"
    assert_match "* [Header](#header)", shell_output("#{bin}/gh-md-toc ./README.md")
  end
end
