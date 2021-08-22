class Dlite < Formula
  desc "Provides a way to use docker on macOS without docker-machine"
  homepage "https://github.com/nlf/dlite"
  url "https://github.com/nlf/dlite/archive/1.1.5.tar.gz"
  sha256 "cfbd99ef79f9657c2927cf5365ab707999a7b51eae759452354aff1a0200de3f"
  head "https://github.com/nlf/dlite.git"



  depends_on "go" => :build

  # DLite depends on the Hypervisor framework which only works on
  # OS X versions 10.10 (Yosemite) or newer
  depends_on :macos => :yosemite

  def install
    ENV["GOPATH"] = buildpath

    path = buildpath/"src/github.com/nlf/dlite"
    path.install Dir["*"]

    cd path do
      system "make", "dlite"
      bin.install "dlite"
      prefix.install_metafiles
    end
  end

  def caveats
    <<~EOS
      Installing and upgrading dlite with brew does not automatically
      install or upgrade the dlite daemon and virtual machine.
    EOS
  end

  test do
    output = shell_output(bin/"dlite version")
    assert_match version.to_s, output
  end
end
