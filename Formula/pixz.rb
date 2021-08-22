class Pixz < Formula
  desc "Parallel, indexed, xz compressor"
  homepage "https://github.com/vasi/pixz"
  url "https://github.com/vasi/pixz/releases/download/v1.0.6/pixz-1.0.6.tar.gz"
  sha256 "c54a406dddc6c2226779aeb4b5d5b5649c1d3787b39794fbae218f7535a1af63"
  revision 1
  head "https://github.com/vasi/pixz.git"



  depends_on "asciidoc" => :build
  depends_on "docbook" => :build
  depends_on "pkg-config" => :build
  depends_on "libarchive"
  depends_on "xz"

  def install
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["libarchive"].opt_lib/"pkgconfig"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"

    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"
    system "a2x", "--doctype", "manpage", "--format", "manpage", "src/pixz.1.asciidoc"
    man1.install "src/pixz.1"
  end

  test do
    ENV["LC_ALL"] = "en_US.UTF-8"
    testfile = testpath/"file.txt"
    testfile.write "foo"
    system "#{bin}/pixz", testfile, "#{testpath}/file.xz"
  end
end
