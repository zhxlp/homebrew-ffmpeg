class BashCompletionAT2 < Formula
  desc "Programmable completion for Bash 4.1+"
  homepage "https://github.com/scop/bash-completion"
  url "https://github.com/scop/bash-completion/releases/download/2.8/bash-completion-2.8.tar.xz"
  sha256 "c01f5570f5698a0dda8dc9cfb2a83744daa1ec54758373a6e349bd903375f54d"



  head do
    url "https://github.com/scop/bash-completion.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "bash"

  conflicts_with "bash-completion", :because => "Differing version of same formula"

  def install
    inreplace "bash_completion", "readlink -f", "readlink"

    system "autoreconf", "-i" if build.head?
    system "./configure", "--prefix=#{prefix}"
    ENV.deparallelize
    system "make", "install"
  end

  def caveats; <<~EOS
    Add the following to your ~/.bash_profile:
      [[ -r "#{etc}/profile.d/bash_completion.sh" ]] && . "#{etc}/profile.d/bash_completion.sh"

    If you'd like to use existing homebrew v1 completions, add the following before the previous line:
      export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
  EOS
  end

  test do
    system "test", "-f", "#{share}/bash-completion/bash_completion"
  end
end
