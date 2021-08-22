class Htmldoc < Formula
  desc "Convert HTML to PDF or PostScript"
  homepage "https://www.msweet.org/htmldoc/"
  url "https://github.com/michaelrsweet/htmldoc/releases/download/v1.9.5/htmldoc-1.9.5-source.tar.gz"
  sha256 "0be1ae7986e01e94d482b3af7dcee19800117c8a61ef67426c30ae7744a79ea6"
  head "https://github.com/michaelrsweet/htmldoc.git"



  depends_on "jpeg"
  depends_on "libpng"

  def install
    system "./configure", "--disable-debug",
                          "--disable-ssl",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/htmldoc", "--version"
  end
end
