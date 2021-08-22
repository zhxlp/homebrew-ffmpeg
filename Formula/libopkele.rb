class Libopkele < Formula
  desc "C++ implementation of OpenID decentralized identity system"
  homepage "http://kin.klever.net/libopkele/"
  revision 2

  stable do
    url "http://kin.klever.net/dist/libopkele-2.0.4.tar.bz2"
    sha256 "102e22431e4ec6f1f0baacb6b1b036476f5e5a83400f2174807a090a14f4dc67"

    # Fix argument-lookup failure on gcc 4.7.1
    patch do
      url "https://github.com/hacker/libopkele/commit/9ff6244998b0d41e71f7cc7351403ad590e990e4.diff?full_index=1"
      sha256 "a06c378b1ededc64eb581a26a82bd56c941df149a83940586ddcf494fac65716"
    end
  end



  head do
    url "https://github.com/hacker/libopkele.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "doxygen" => :build
  depends_on "pkg-config" => :build

  # It rejects the tr1/memory that ships on 10.9 & above
  # and refuses to compile. It can use Boost, per configure.
  depends_on "boost"

  depends_on "openssl"

  def install
    system "./autogen.bash" if build.head?
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"

    system "make", "dox"
    doc.install "doxydox/html"
  end
end
