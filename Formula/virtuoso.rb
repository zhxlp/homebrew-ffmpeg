class Virtuoso < Formula
  desc "High-performance object-relational SQL database"
  homepage "https://virtuoso.openlinksw.com/wiki/main/"
  url "https://github.com/openlink/virtuoso-opensource/releases/download/v7.2.5.1/virtuoso-opensource-7.2.5.tar.gz"
  # Upstream pushed a hot-fix retag of 7.2.5 as 7.2.5.1.
  # This explicit version should be safe to remove next release.
  version "7.2.5.1"
  sha256 "826477d25a8493a68064919873fb4da4823ebe09537c04ff4d26ba49d9543d64"



  head do
    url "https://github.com/openlink/virtuoso-opensource.git", :branch => "develop/7"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  # If gawk isn't found, make fails deep into the process.
  depends_on "gawk" => :build
  depends_on "openssl"

  conflicts_with "unixodbc", :because => "Both install `isql` binaries."

  skip_clean :la

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  def caveats; <<~EOS
    NOTE: the Virtuoso server will start up several times on port 1111
    during the install process.
  EOS
  end

  test do
    system bin/"virtuoso-t", "+checkpoint-only"
  end
end
