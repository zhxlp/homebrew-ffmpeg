require "language/node"

class CashCli < Formula
  desc "Exchange Currency Rates using your terminal"
  homepage "https://github.com/xxczaki/cash-cli"
  url "https://registry.npmjs.org/cash-cli/-/cash-cli-2.0.8.tgz"
  sha256 "d2c6b10d44a8b7aca356db64d5eb46a77ee754394c43fb0dd0772bdebc5a3167"



  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "Conversion of INR 100", shell_output("#{bin}/cash 100 INR USD GBP")
  end
end
