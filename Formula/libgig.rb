class Libgig < Formula
  desc "Library for Gigasampler and DLS (Downloadable Sounds) Level 1/2 files"
  homepage "https://www.linuxsampler.org/libgig/"
  url "https://download.linuxsampler.org/packages/libgig-4.1.0.tar.bz2"
  sha256 "06a280278a323963042acdf13b092644cceb43ef367fcbb9ca7bbedff132bd0b"



  depends_on "pkg-config" => :build
  depends_on "libsndfile"

  def install
    # parallel make does not work, fixed in next version (4.0.0)
    ENV.deparallelize
    # link with CoreFoundation, default in next version (4.0.0)
    ENV.append "LDFLAGS", "-framework CoreFoundation"

    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <libgig/gig.h>
      #include <iostream>
      using namespace std;

      int main()
      {
        cout << gig::libraryName() << endl;
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-L#{lib}/libgig", "-lgig", "-o", "test"
    assert_match "libgig", shell_output("./test")
  end
end
