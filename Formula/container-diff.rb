class ContainerDiff < Formula
  desc "Diff your Docker containers"
  homepage "https://github.com/GoogleContainerTools/container-diff"
  url "https://github.com/GoogleContainerTools/container-diff/archive/v0.14.0.tar.gz"
  sha256 "5dbafdc38524dad60286da2d7a7d303285de2e08e070ce3dcc1488dbfecd116b"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/GoogleContainerTools").mkpath
    ln_sf buildpath, buildpath/"src/github.com/GoogleContainerTools/container-diff"

    cd "src/github.com/GoogleContainerTools/container-diff" do
      system "make"
      bin.install "out/container-diff"
    end
  end

  test do
    image = "daemon://gcr.io/google-appengine/golang:2018-01-04_15_24"
    output = shell_output("#{bin}/container-diff analyze #{image} 2>&1", 1)
    assert_match "Cannot connect to the Docker daemon", output
  end
end
