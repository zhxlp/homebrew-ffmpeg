class DockerLs < Formula
  desc "Tools for browsing and manipulating docker registries"
  homepage "https://github.com/mayflower/docker-ls"
  url "https://github.com/mayflower/docker-ls.git",
      :tag      => "v0.3.2",
      :revision => "d371240c3dd46a73f9c516475d5f611c8f699419"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    (buildpath/"src/github.com/mayflower/docker-ls").install buildpath.children

    system "go", "generate", "github.com/mayflower/docker-ls/lib"

    cd "src/github.com/mayflower/docker-ls" do
      system "go", "build", "-o", bin/"docker-ls", "./cli/docker-ls"
      system "go", "build", "-o", bin/"docker-rm", "./cli/docker-rm"
      prefix.install_metafiles
    end
  end

  test do
    assert_match /\Wlatest\W/m, pipe_output("#{bin}/docker-ls tags \
      -r https://index.docker.io -u '' -p '' \
      --progress-indicator=false library/busybox \
    ")

    assert_match /401/, pipe_output("#{bin}/docker-rm  \
      -r https://index.docker.io -u foo -p bar library/busybox:latest 2<&1 \
    ")
  end
end
