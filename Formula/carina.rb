class Carina < Formula
  desc "Command-line client for Carina"
  homepage "https://github.com/getcarina/carina"
  url "https://github.com/getcarina/carina.git",
        :tag      => "v2.1.3",
        :revision => "2b3ec267e298e095d7c2f81a2d82dc50a720e81c"
  head "https://github.com/getcarina/carina.git"



  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV.prepend_create_path "PATH", buildpath/"bin"

    carinapath = buildpath/"src/github.com/getcarina/carina"
    carinapath.install Dir["{*,.git}"]

    cd carinapath do
      system "make", "get-deps"
      system "make", "local", "VERSION=#{version}"
      bin.install "carina"
      prefix.install_metafiles
    end
  end

  test do
    system "#{bin}/carina", "--version"
  end
end
