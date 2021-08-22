class Saldl < Formula
  desc "CLI downloader optimized for speed and early preview"
  homepage "https://saldl.github.io/"
  url "https://github.com/saldl/saldl/archive/v40.tar.gz"
  sha256 "1cb7950848517fb82ec39561bf36c8cbc0a0caf8fa85355a5b76cac0281346ce"
  head "https://github.com/saldl/saldl.git", :shallow => false



  depends_on "asciidoc" => :build
  depends_on "docbook-xsl" => :build
  depends_on "pkg-config" => :build
  depends_on "curl" # curl >= 7.55 is required
  depends_on "libevent"

  def install
    ENV.refurbish_args

    # a2x/asciidoc needs this to build the man page successfully
    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"

    args = ["--prefix=#{prefix}"]

    # head uses git describe to acquire a version
    args << "--saldl-version=v#{version}" unless build.head?

    system "./waf", "configure", *args
    system "./waf", "build"
    system "./waf", "install"
  end

  test do
    system "#{bin}/saldl", "https://brew.sh/index.html"
    assert_predicate testpath/"index.html", :exist?
  end
end
