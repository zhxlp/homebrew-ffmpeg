class Up < Formula
  desc "Tool for writing command-line pipes with instant live preview"
  homepage "https://github.com/akavel/up"
  url "https://github.com/akavel/up/archive/v0.3.2.tar.gz"
  sha256 "359510cfea8af8f14de39d63f63cc5c765f681cca2c37f00174837d52c62cad1"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = HOMEBREW_CACHE/"go_cache"
    dir = buildpath/"src/github.com/akavel/up"
    dir.install buildpath.children

    cd dir do
      system "go", "build", "-o", bin/"up", "up.go"
      prefix.install_metafiles
    end
  end

  test do
    shell_output("#{bin}/up --debug 2&>1", 1)
    assert_predicate testpath/"up.debug", :exist?, "up.debug not found"
    assert_includes File.read(testpath/"up.debug"), "checking $SHELL"
  end
end
