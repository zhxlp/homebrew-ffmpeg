class Syntaxerl < Formula
  desc "Syntax checker for Erlang code and config files"
  homepage "https://github.com/ten0s/syntaxerl"
  url "https://github.com/ten0s/syntaxerl/archive/0.14.0.tar.gz"
  sha256 "a7c46789aadf467191f43b82ac6a428faf4d38af2965fdcd946789a7f40439fc"



  depends_on "erlang"

  def install
    system "make"
    bin.install "_build/default/bin/syntaxerl"
  end

  test do
    (testpath/"app.config").write "[{app,[{arg1,1},{arg2,2}]}]."
    assert_equal "", shell_output("#{bin}/syntaxerl #{testpath}/app.config")

    (testpath/"invalid.config").write "]["
    assert_match "invalid.config:1: syntax error before: ']'", shell_output("#{bin}/syntaxerl #{testpath}/invalid.config", 1)
  end
end
