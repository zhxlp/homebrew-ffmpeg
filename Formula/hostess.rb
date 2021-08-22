class Hostess < Formula
  desc "Idempotent command-line utility for managing your /etc/hosts file"
  homepage "https://github.com/cbednarski/hostess"
  url "https://github.com/cbednarski/hostess/archive/v0.3.0.tar.gz"
  sha256 "9b1f72f8657dd15482a429b33fc7bdb28c7a06137330b59f0eaef956c857ed59"
  head "https://github.com/cbednarski/hostess.git"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    dir = buildpath/"src/github.com/cbednarski/hostess"
    dir.install buildpath.children

    cd dir/"cmd/hostess" do
      system "go", "install"
    end
    bin.install "bin/hostess"
  end

  test do
    system bin/"hostess", "--help"
  end
end
