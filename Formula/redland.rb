class Redland < Formula
  desc "RDF Library"
  homepage "http://librdf.org/"
  url "http://download.librdf.org/source/redland-1.0.17.tar.gz"
  sha256 "de1847f7b59021c16bdc72abb4d8e2d9187cd6124d69156f3326dd34ee043681"
  revision 1



  depends_on "pkg-config" => :build
  depends_on "raptor"
  depends_on "rasqal"
  depends_on "sqlite"
  depends_on "unixodbc"

  resource "bindings" do
    url "http://download.librdf.org/source/redland-bindings-1.0.17.1.tar.gz"
    sha256 "ff72b587ab55f09daf81799cb3f9d263708fad5df7a5458f0c28566a2563b7f5"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-bdb=no",
                          "--with-mysql=no",
                          "--with-sqlite=yes"
    system "make", "install"
  end
end
