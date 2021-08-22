require "language/go"

class SpaceinvadersGo < Formula
  desc "Space Invaders in your terminal written in Go"
  homepage "https://github.com/asib/spaceinvaders"
  url "https://github.com/asib/spaceinvaders/archive/v1.2.tar.gz"
  sha256 "e5298c4c13ff42f5cb3bf3913818c5155cf6918fd757124920045485d7ab5b9e"



  depends_on "go" => :build

  go_resource "github.com/mattn/go-runewidth" do
    url "https://github.com/mattn/go-runewidth.git",
        :revision => "12e0ff74603c9a3209d8bf84f8ab349fe1ad9477"
  end

  go_resource "github.com/nsf/termbox-go" do
    url "https://github.com/nsf/termbox-go.git",
        :revision => "347ab0bc907040257edaf8b580f729e12c93ab6b"
  end

  go_resource "github.com/simulatedsimian/joystick" do
    url "https://github.com/simulatedsimian/joystick.git",
        :revision => "6aa8abe045a796cf36b720d0484809e3f70dc5bd"
  end

  def install
    # This builds with Go.
    ENV["GOPATH"] = buildpath
    sipath = buildpath/"src/github.com/asib/spaceinvaders"
    sipath.install Dir["{*,.git}"]
    Language::Go.stage_deps resources, buildpath/"src"
    cd "src/github.com/asib/spaceinvaders/" do
      system "go", "build"
      bin.install "spaceinvaders"
      prefix.install_metafiles
    end
  end

  test do
    IO.popen("#{bin}/spaceinvaders", "r+") do |pipe|
      pipe.puts "q"
      pipe.close_write
      pipe.close
    end
  end
end
