require "language/go"

class Mmark < Formula
  desc "Powerful markdown processor in Go geared towards the IETF"
  homepage "https://mmark.nl/"
  url "https://github.com/mmarkdown/mmark/archive/v2.0.7.tar.gz"
  sha256 "8ab83495b21d0b05fd763f3a79aeaf983c6905eccfbcca48f63c169ef3705639"



  depends_on "go" => :build

  go_resource "github.com/BurntSushi/toml" do
    url "https://github.com/BurntSushi/toml.git",
        :revision => "3012a1dbe2e4bd1391d42b32f0577cb7bbc7f005"
  end

  go_resource "github.com/gomarkdown/markdown" do
    url "https://github.com/gomarkdown/markdown.git",
        :revision => "6fda95a9e93f739db582f4a3514309830fd47354"
  end

  go_resource "github.com/mmarkdown/markdown" do
    url "https://github.com/mmarkdown/markdown.git",
        :revision => "6fda95a9e93f739db582f4a3514309830fd47354"
  end

  resource "test" do
    url "https://raw.githubusercontent.com/mmarkdown/mmark/v2.0.7/rfc/2100.md"
    sha256 "2d220e566f8b6d18cf584290296c45892fe1a010c38d96fb52a342e3d0deda30"
  end

  def install
    ENV["GOPATH"] = buildpath
    mkdir_p buildpath/"src/github.com/mmarkdown/"
    ln_sf buildpath, buildpath/"src/github.com/mmarkdown/mmark"
    Language::Go.stage_deps resources, buildpath/"src"

    system "go", "build", "-o", bin/"mmark"
    man1.install "mmark.1"
    doc.install "Syntax.md"
  end

  test do
    resource("test").stage do
      system "#{bin}/mmark", "-2", "-ast", "2100.md"
    end
  end
end
