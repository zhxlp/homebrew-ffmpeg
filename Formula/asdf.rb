class Asdf < Formula
  desc "Extendable version manager with support for Ruby, Node.js, Erlang & more"
  homepage "https://github.com/asdf-vm"
  url "https://github.com/asdf-vm/asdf/archive/v0.6.3.tar.gz"
  sha256 "01fb75889b854034ed95c1c728dd53564256ecee6fc7167919283f3b654a4e1d"
  head "https://github.com/asdf-vm/asdf.git"

  bottle :unneeded

  depends_on "autoconf"
  depends_on "automake"
  depends_on "coreutils"
  depends_on "libtool"
  depends_on "libyaml"
  depends_on "openssl"
  depends_on "readline"
  depends_on "unixodbc"

  conflicts_with "homeshick",
    :because => "asdf and homeshick both install files in lib/commands"

  def install
    bash_completion.install "completions/asdf.bash"
    fish_completion.install "completions/asdf.fish"
    libexec.install "bin/private"
    prefix.install Dir["*"]

    inreplace "#{lib}/commands/reshim.sh",
              "exec $(asdf_dir)/bin/private/asdf-exec ",
              "exec $(asdf_dir)/libexec/private/asdf-exec "
  end

  test do
    output = shell_output("#{bin}/asdf plugin-list 2>&1", 1)
    assert_match "Oohes nooes ~! No plugins installed", output
  end
end
