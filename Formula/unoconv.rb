class Unoconv < Formula
  desc "Convert between any document format supported by OpenOffice"
  homepage "http://dag.wiee.rs/home-made/unoconv/"
  url "https://files.pythonhosted.org/packages/a2/b8/3131d20bfa2065e489edc7ca2dbfd66fd8d4fcbbde3476c76605a7e69269/unoconv-0.8.2.tar.gz"
  sha256 "c7091a409384c05b3509b18be6c8d7059d26f491dfa78660ecdfbde3e72b03be"
  revision 1
  head "https://github.com/dagwieers/unoconv.git"



  depends_on "python"

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  def caveats; <<~EOS
    In order to use unoconv, a copy of LibreOffice between versions 3.6.0.1 - 4.3.x must be installed.
  EOS
  end
end
