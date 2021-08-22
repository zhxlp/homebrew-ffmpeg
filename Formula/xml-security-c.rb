class XmlSecurityC < Formula
  desc "Implementation of primary security standards for XML"
  homepage "https://santuario.apache.org/"
  url "https://archive.apache.org/dist//santuario/c-library/xml-security-c-2.0.2.tar.bz2"
  mirror "https://archive.apache.org/dist/santuario/c-library/xml-security-c-2.0.2.tar.bz2"
  sha256 "39e963ab4da477b7bda058f06db37228664c68fe68902d86e334614dd06e046b"



  depends_on "pkg-config" => :build
  depends_on "openssl"
  depends_on "xerces-c"

  def install
    ENV.cxx11

    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking",
                          "--with-openssl=#{Formula["openssl"].opt_prefix}"
    system "make", "install"
  end

  test do
    assert_match /All tests passed/, pipe_output("#{bin}/xsec-xtest 2>&1")
  end
end
