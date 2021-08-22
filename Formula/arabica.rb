class Arabica < Formula
  desc "XML toolkit written in C++"
  homepage "https://www.jezuk.co.uk/cgi-bin/view/arabica"
  url "https://github.com/jezhiggins/arabica/archive/2016-January.tar.gz"
  version "20160214"
  sha256 "addcbd13a6f814a8c692cff5d4d13491f0b12378d0ee45bdd6801aba21f9f2ae"
  head "https://github.com/jezhiggins/arabica.git"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "boost"

  def install
    system "autoreconf", "-fvi"
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/mangle")
    assert_match "mangle is an (in-development) XSLT processor", output
  end
end
