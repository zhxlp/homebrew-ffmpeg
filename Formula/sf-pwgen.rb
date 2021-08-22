class SfPwgen < Formula
  desc "Generate passwords using SecurityFoundation framework"
  homepage "https://github.com/anders/pwgen/"
  url "https://github.com/anders/pwgen/archive/v1.4.tar.gz"
  sha256 "1f4c7f514426305be2e1b893a586310d579e500e033938800afd2c98fedb84d9"
  head "https://github.com/anders/pwgen.git"



  def install
    system "make"
    bin.install "sf-pwgen"
  end

  test do
    assert_equal 20, shell_output("#{bin}/sf-pwgen -a memorable -c 1 -l 20").chomp.length
  end
end
