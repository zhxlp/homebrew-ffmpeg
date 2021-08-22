class Pumba < Formula
  desc "Chaos testing tool for Docker"
  homepage "https://github.com/alexei-led/pumba"
  url "https://github.com/alexei-led/pumba/archive/0.6.2.tar.gz"
  sha256 "d94be5696cde2b1c6ef409040f24b8b1260d3a34b9e40f08dd492c2aa0c5b656"
  head "https://github.com/alexei-led/pumba.git"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/alexei-led/pumba").install buildpath.children

    cd "src/github.com/alexei-led/pumba" do
      system "go", "build", "-o", bin/"pumba", "-ldflags",
             "-X main.Version=#{version}", "./cmd"
      prefix.install_metafiles
    end
  end

  test do
    output = pipe_output("#{bin}/pumba rm test-container 2>&1")
    assert_match "Is the docker daemon running?", output
  end
end
