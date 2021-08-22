class ThePlatinumSearcher < Formula
  desc "Multi-platform code-search similar to ack and ag"
  homepage "https://github.com/monochromegane/the_platinum_searcher"
  url "https://github.com/monochromegane/the_platinum_searcher/archive/v2.2.0.tar.gz"
  sha256 "3d5412208644b13723b2b7ca4af0870d25c654e3a76feee846164c51b88240b0"
  head "https://github.com/monochromegane/the_platinum_searcher.git"



  depends_on "go" => :build
  depends_on "godep" => :build

  def install
    ENV["GOPATH"] = buildpath
    dir = buildpath/"src/github.com/monochromegane/the_platinum_searcher"
    dir.install buildpath.children
    cd dir do
      system "godep", "restore"
      system "go", "build", "-o", bin/"pt", ".../cmd/pt"
      prefix.install_metafiles
    end
  end

  test do
    path = testpath/"hello_world.txt"
    path.write "Hello World!"

    lines = `#{bin}/pt 'Hello World!' #{path}`.strip.split(":")
    assert_equal "Hello World!", lines[2]
  end
end
