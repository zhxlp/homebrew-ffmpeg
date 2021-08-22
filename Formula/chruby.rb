class Chruby < Formula
  desc "Ruby environment tool"
  homepage "https://github.com/postmodern/chruby#readme"
  url "https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz"
  sha256 "7220a96e355b8a613929881c091ca85ec809153988d7d691299e0a16806b42fd"
  head "https://github.com/postmodern/chruby.git"



  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  def caveats; <<~EOS
    Add the following to the ~/.bash_profile or ~/.zshrc file:
      source #{opt_pkgshare}/chruby.sh

    To enable auto-switching of Rubies specified by .ruby-version files,
    add the following to ~/.bash_profile or ~/.zshrc:
      source #{opt_pkgshare}/auto.sh
  EOS
  end

  test do
    assert_equal "chruby version #{version}", shell_output("#{bin}/chruby-exec --version").strip
  end
end
