require "language/go"

class Wego < Formula
  desc "Weather app for the terminal"
  homepage "https://github.com/schachmat/wego"
  url "https://github.com/schachmat/wego/archive/2.0.tar.gz"
  sha256 "d63d79520b385c4ed921c7decc37a0b85c40af66600f8a5733514e04d3048075"
  head "https://github.com/schachmat/wego.git"



  depends_on "go" => :build

  go_resource "github.com/mattn/go-colorable" do
    url "https://github.com/mattn/go-colorable.git",
        :revision => "ed8eb9e318d7a84ce5915b495b7d35e0cfe7b5a8"
  end

  go_resource "github.com/mattn/go-runewidth" do
    url "https://github.com/mattn/go-runewidth.git",
        :revision => "d6bea18f789704b5f83375793155289da36a3c7f"
  end

  go_resource "github.com/schachmat/ingo" do
    url "https://github.com/schachmat/ingo.git",
        :revision => "b1887f863beaeb31b3924e839dfed3cf3a981ea8"
  end

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/schachmat").mkpath
    ln_sf buildpath, buildpath/"src/github.com/schachmat/wego"
    Language::Go.stage_deps resources, buildpath/"src"
    system "go", "build", "-o", bin/"wego"
  end

  test do
    ENV["WEGORC"] = testpath/".wegorc"
    assert_match /No .*API key specified./, shell_output("#{bin}/wego 2>&1", 1)
  end
end
