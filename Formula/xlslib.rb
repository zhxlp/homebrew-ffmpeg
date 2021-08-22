class Xlslib < Formula
  desc "C++/C library to construct Excel .xls files in code"
  homepage "https://sourceforge.net/projects/xlslib"
  url "https://downloads.sourceforge.net/project/xlslib/xlslib-package-2.5.0.zip"
  mirror "https://dl.bintray.com/homebrew/mirror/xlslib-package-2.5.0.zip"
  sha256 "05a5d052ffdd6590755949d80d16a56285561557bc9a5e887e3b8b3fef92a3f3"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    cd "xlslib"
    system "autoreconf", "-i" # shipped configure hardcodes automake-1.13
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
