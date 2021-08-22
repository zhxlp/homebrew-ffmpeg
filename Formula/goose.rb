class Goose < Formula
  desc "Go Language's command-line interface for database migrations"
  homepage "https://github.com/pressly/goose"
  url "https://github.com/pressly/goose/archive/v2.3.0.tar.gz"
  sha256 "f19ec6ef1bae596e013a40c300d7f28ba91f71f6f7d6d0f13d03feaf4ab1ac43"



  depends_on "dep" => :build
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/pressly/goose").install buildpath.children
    cd "src/github.com/pressly/goose" do
      system "dep", "ensure"
      system "go", "build", "-o", bin/"goose", ".../cmd/goose"
      prefix.install_metafiles
    end
  end

  test do
    output = shell_output("#{bin}/goose sqlite3 foo.db status create 2>&1")
    assert_match "Migration", output
    assert_predicate testpath/"foo.db", :exist?, "Failed to create foo.db!"
  end
end
