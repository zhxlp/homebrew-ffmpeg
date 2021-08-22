class Genstats < Formula
  desc "Generate statistics about stdin or textfiles"
  homepage "https://www.vanheusden.com/genstats/"
  url "https://www.vanheusden.com/genstats/genstats-1.2.tgz"
  sha256 "f0fb9f29750cdaa85dba648709110c0bc80988dd6a98dd18a53169473aaa6ad3"



  def install
    # Tried to make this a patch.  Applying the patch hunk would
    # fail, even though I used "git diff | pbcopy". Tried messing
    # with whitespace, # lines, etc.  Ugh.
    inreplace "br.cpp", /if \(_XOPEN_VERSION >= 600\)/,
                        "if (_XOPEN_VERSION >= 600) && !__APPLE__"

    system "make"
    bin.install "genstats"
    man.install "genstats.1"
  end

  test do
    output = shell_output("#{bin}/genstats -h", 1)
    assert_match "folkert@vanheusden.com", output
  end
end
