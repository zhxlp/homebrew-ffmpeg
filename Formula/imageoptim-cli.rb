require "language/node"

class ImageoptimCli < Formula
  desc "CLI for ImageOptim, ImageAlpha and JPEGmini"
  homepage "https://jamiemason.github.io/ImageOptim-CLI/"
  url "https://github.com/JamieMason/ImageOptim-CLI/archive/2.0.4.tar.gz"
  sha256 "c26ba12425f100ab16e992f607e6d69527a6572b55cf287f5321a62ee61af390"



  depends_on "node" => :build

  resource "node" do
    url "https://nodejs.org/dist/v10.9.0/node-v10.9.0.tar.xz"
    sha256 "d17ef8eb72d6a31f50a663d554beb9bcb55aa2ce57cf189abfc9b1ba20530d02"
  end

  def install
    # build node from source instead of downloading precompiled nexe node binary
    resource("node").stage buildpath/".brew_home/.nexe"
    inreplace "package.json", "\"build:bin\": \"nexe --target 'mac-x64-10.0.0' --input",
      "\"build:bin\": \"nexe --build --target 'mac-x64-#{resource("node").version}' --loglevel=verbose --input"

    system "npm", "ci", *Language::Node.local_npm_install_args
    system "npm", "run-script", "build"
    libexec.install "dist", "osascript"
    bin.install_symlink libexec/"dist/imageoptim"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/imageoptim -V").chomp
  end
end
