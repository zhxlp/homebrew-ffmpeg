require "language/go"

class Wiki < Formula
  desc "Fetch summaries from MediaWiki wikis, like Wikipedia"
  homepage "https://github.com/walle/wiki"
  url "https://github.com/walle/wiki/archive/1.4.0.tar.gz"
  sha256 "b9adb27485feba68574e3abf5564577f2fcec1bf2176fc8f80b09b6f8ca6ffff"



  depends_on "go" => :build

  go_resource "github.com/mattn/go-colorable" do
    url "https://github.com/mattn/go-colorable.git",
        :revision => "40e4aedc8fabf8c23e040057540867186712faa5"
  end

  def install
    ENV["GOPATH"] = buildpath
    wikipath = buildpath/"src/github.com/walle/wiki"
    wikipath.install Dir["{*,.git}"]
    Language::Go.stage_deps resources, buildpath/"src"

    cd "src/github.com/walle/wiki" do
      system "go", "build", "-o", "build/wiki", "cmd/wiki/main.go"
      bin.install "build/wiki"
      man1.install "_doc/wiki.1"
      prefix.install_metafiles
    end
  end

  test do
    assert_match "Read more: https://en.wikipedia.org/wiki/Go", shell_output("#{bin}/wiki golang")
  end
end
