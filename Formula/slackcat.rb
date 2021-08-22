class Slackcat < Formula
  desc "Command-line utility for posting snippets to Slack"
  homepage "https://github.com/vektorlab/slackcat"
  url "https://github.com/vektorlab/slackcat/archive/v1.4.tar.gz"
  sha256 "43c80b7d546bca51af47b3df8b79a2e5ce021042ea91d877e2feb33a7ca81305"



  depends_on "dep" => :build
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/vektorlab/slackcat").install buildpath.children
    cd "src/github.com/vektorlab/slackcat" do
      system "dep", "ensure", "-vendor-only"
      system "go", "build", "-o", bin/"slackcat",
           "-ldflags", "-X main.version=#{version}"
      prefix.install_metafiles
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/slackcat -v")
  end
end
