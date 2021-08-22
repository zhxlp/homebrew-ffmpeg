class Kyua < Formula
  desc "Testing framework for infrastructure software"
  homepage "https://github.com/jmmv/kyua"
  url "https://github.com/jmmv/kyua/releases/download/kyua-0.13/kyua-0.13.tar.gz"
  sha256 "db6e5d341d5cf7e49e50aa361243e19087a00ba33742b0855d2685c0b8e721d6"
  revision 1



  depends_on "pkg-config" => :build
  depends_on "atf"
  depends_on "lua"
  depends_on "lutok"
  depends_on "sqlite"

  def install
    ENV.append "CPPFLAGS", "-I#{Formula["lua"].opt_include}/lua"

    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    ENV.deparallelize
    system "make", "install"
  end
end
