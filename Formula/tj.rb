class Tj < Formula
  desc "Line timestamping tool"
  homepage "https://github.com/sgreben/tj"
  url "https://github.com/sgreben/tj/archive/7.0.0.tar.gz"
  sha256 "6f9f988a05f9089d2a96edd046d673392d6fac2ea74ff0999b2f0428e9f72f7f"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/sgreben/tj").install buildpath.children
    cd "src/github.com/sgreben/tj" do
      system "make", "binaries/osx_x86_64/tj"
      bin.install "binaries/osx_x86_64/tj"
      prefix.install_metafiles
    end
  end

  test do
    system bin/"tj", "test"
  end
end
