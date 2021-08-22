class Qpm < Formula
  desc "Package manager for Qt applications"
  homepage "https://www.qpm.io"
  url "https://github.com/Cutehacks/qpm.git",
      :tag      => "v0.11.0",
      :revision => "fc340f20ddcfe7e09f046fd22d2af582ff0cd4ef"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src").mkpath
    ln_s buildpath, "src/qpm.io"
    system "go", "build", "-o", "bin/qpm", "qpm.io/qpm"
    bin.install "bin/qpm"
  end

  test do
    system bin/"qpm", "install", "io.qpm.example"
    assert_predicate testpath/"qpm.json", :exist?
  end
end
