require "language/node"

class IosSim < Formula
  desc "Command-line application launcher for the iOS Simulator"
  homepage "https://github.com/phonegap/ios-sim"
  url "https://registry.npmjs.org/ios-sim/-/ios-sim-7.0.0.tgz"
  sha256 "6893781e5caa9e036bfe2044b3044c3a937b2b96b5de18bed3e93b7508a87615"
  head "https://github.com/phonegap/ios-sim.git"



  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system bin/"ios-sim", "--help"
  end
end
