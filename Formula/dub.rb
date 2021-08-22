class Dub < Formula
  desc "Build tool for D projects"
  homepage "https://code.dlang.org/getting_started"
  url "https://github.com/dlang/dub/archive/v1.13.0.tar.gz"
  sha256 "8c7ffdae0b49bd1a246f48e865610fc5b6f6bdf58057858f3ba7e9dae8368ee7"
  version_scheme 1
  head "https://github.com/dlang/dub.git"



  depends_on "dmd" => :build
  depends_on "pkg-config"

  def install
    ENV["GITVER"] = version.to_s
    system "./build.sh"
    bin.install "bin/dub"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dub --version").split(/[ ,]/)[2]
  end
end
