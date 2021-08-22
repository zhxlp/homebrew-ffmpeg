class Exa < Formula
  desc "Modern replacement for 'ls'"
  homepage "https://the.exa.website"
  url "https://github.com/ogham/exa/archive/v0.8.0.tar.gz"
  sha256 "07085fd784d553b7c3b62b5a52e4635580d6154f47e6d64245ec0588638dee3e"
  head "https://github.com/ogham/exa.git"



  depends_on "cmake" => :build
  depends_on "rust" => :build

  def install
    system "make", "install", "PREFIX=#{prefix}"

    bash_completion.install "contrib/completions.bash" => "exa"
    zsh_completion.install  "contrib/completions.zsh"  => "_exa"
    fish_completion.install "contrib/completions.fish" => "exa.fish"
  end

  test do
    (testpath/"test.txt").write("")
    assert_match "test.txt", shell_output("#{bin}/exa")
  end
end
