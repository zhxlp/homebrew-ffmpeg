class Prest < Formula
  desc "Serve a RESTful API from any PostgreSQL database"
  homepage "https://github.com/prest/prest"
  url "https://github.com/prest/prest/archive/v0.3.4.tar.gz"
  sha256 "cc45eb5de17a1957124545e11ae6dcc6e3957e9d5e9b06acf37a341113963829"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/prest/prest").install buildpath.children
    cd "src/github.com/prest/prest" do
      system "go", "build", "-ldflags",
             "-X github.com/prest/prest/vendor/github.com/prest/helpers.PrestVersionNumber=#{version}",
             "-o", bin/"prest"
      prefix.install_metafiles
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prest version")
  end
end
