class Grv < Formula
  desc "Terminal interface for viewing git repositories"
  homepage "https://github.com/rgburke/grv"
  url "https://github.com/rgburke/grv/releases/download/v0.3.1/grv-0.3.1-src.tar.gz"
  sha256 "604f927a40218f6d7dff2188f796bb47c4ababff203f11a6f7ebce2f1967b6f0"
  revision 1
  head "https://github.com/rgburke/grv.git"



  depends_on "cmake" => :build
  depends_on "go" => :build
  depends_on "pkg-config" => :build
  depends_on "ncurses" if DevelopmentTools.clang_build_version >= 1000
  depends_on "readline"

  def install
    ENV["GOPATH"] = buildpath
    path = buildpath/"src/github.com/rgburke/grv"
    path.install buildpath.children

    cd path do
      system "make", "build-only"
      bin.install "grv"
      prefix.install_metafiles
    end
  end

  test do
    ENV["TERM"] = "xterm"

    system "git", "init"
    system "git", "commit", "--allow-empty", "-m", "test"
    pipe_output("#{bin}/grv -logLevel DEBUG", "'<grv-exit>'", 0)

    assert_predicate testpath/"grv.log", :exist?
    assert_match "Loaded HEAD", File.read(testpath/"grv.log")
  end
end
