require "language/go"

class Wellington < Formula
  desc "Project-focused tool to manage Sass and spriting"
  homepage "https://getwt.io/"
  url "https://github.com/wellington/wellington/archive/v1.0.4.tar.gz"
  sha256 "ef92d6c2b11fe36f66b88612e7a9cfff3ea6f81f29f4c21481d358f474a191d6"
  head "https://github.com/wellington/wellington.git"



  depends_on "go" => :build
  depends_on "pkg-config" => :build

  go_resource "golang.org/x/net" do
    url "https://github.com/golang/net.git",
        :revision => "f09c4662a0bd6bd8943ac7b4931e185df9471da4"
  end

  def install
    ENV["GOPATH"] = buildpath

    dir = buildpath/"src/github.com/wellington/wellington"
    dir.install buildpath.children
    Language::Go.stage_deps resources, buildpath/"src"

    cd dir do
      system "go", "build", "-ldflags",
             "-X github.com/wellington/wellington/version.Version=#{version}",
             "-o", bin/"wt", "wt/main.go"
      prefix.install_metafiles
    end
  end

  test do
    s = "div { p { color: red; } }"
    expected = <<~EOS
      /* line 1, stdin */
      div p {
        color: red; }
    EOS
    assert_equal expected, pipe_output("#{bin}/wt --comment", s, 0)
  end
end
