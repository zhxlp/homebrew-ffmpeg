class OpenSp < Formula
  desc "SGML parser"
  homepage "https://openjade.sourceforge.io"
  url "https://downloads.sourceforge.net/project/openjade/opensp/1.5.2/OpenSP-1.5.2.tar.gz"
  sha256 "57f4898498a368918b0d49c826aa434bb5b703d2c3b169beb348016ab25617ce"



  depends_on "docbook" => :build
  depends_on "ghostscript" => :build
  depends_on "xmlto" => :build

  def install
    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--enable-http",
                          "--enable-default-catalog=#{etc}/sgml/catalog"

    system "make", "pkgdatadir=#{share}/sgml/opensp", "install"
  end

  test do
    (testpath/"eg.sgml").write <<~EOS
      <!DOCTYPE TESTDOC [

      <!ELEMENT TESTDOC - - (TESTELEMENT)+>
      <!ELEMENT TESTELEMENT - - (#PCDATA)>

      ]>
      <TESTDOC>
        <TESTELEMENT>Hello</TESTELEMENT>
      </TESTDOC>
    EOS

    system "#{bin}/onsgmls", "--warning=type-valid", "eg.sgml"
  end
end
