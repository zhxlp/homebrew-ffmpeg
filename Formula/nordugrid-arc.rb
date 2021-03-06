class NordugridArc < Formula
  desc "Grid computing middleware"
  homepage "http://www.nordugrid.org/"
  url "https://download.nordugrid.org/packages/nordugrid-arc/releases/5.0.2/src/nordugrid-arc-5.0.2.tar.gz"
  sha256 "d7306d91b544eeba571ede341e43760997c46d4ccdacc8b785c64f594780a9d1"



  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "glib"
  depends_on "glibmm"
  depends_on "globus-toolkit"
  depends_on "libxml2"

  # build fails on Mavericks due to a clang compiler bug
  # and bottling also fails if gcc is being used due to conflicts between
  # libc++ and libstdc++
  depends_on :macos => :yosemite

  # bug filed upstream at https://bugzilla.nordugrid.org/show_bug.cgi?id=3514
  patch do
    url "https://gist.githubusercontent.com/tschoonj/065dabc33be5ec636058/raw/beee466cdf5fe56f93af0b07022532b1945e9d2e/nordugrid-arc.diff"
    sha256 "5561ea013ddd03ee4f72437f2e01f22b2c0cac2806bf837402724be281ac2b6d"
  end

  def install
    ENV.cxx11
    system "./configure", "--disable-dependency-tracking",
                          "--disable-swig",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"foo").write("data")
    system "#{bin}/arccp", "foo", "bar"
  end
end
