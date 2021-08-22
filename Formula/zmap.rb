class Zmap < Formula
  desc "Network scanner for Internet-wide network studies"
  homepage "https://zmap.io"
  url "https://github.com/zmap/zmap/archive/v2.1.1.tar.gz"
  sha256 "29627520c81101de01b0213434adb218a9f1210bfd3f2dcfdfc1f975dbce6399"
  revision 1
  head "https://github.com/zmap/zmap.git"



  depends_on "byacc" => :build
  depends_on "cmake" => :build
  depends_on "gengetopt" => :build
  depends_on "pkg-config" => :build
  depends_on "gmp"
  depends_on "json-c"
  depends_on "libdnet"

  def install
    inreplace ["conf/zmap.conf", "src/zmap.c", "src/zopt.ggo.in"], "/etc", etc

    system "cmake", ".", *std_cmake_args, "-DENABLE_DEVELOPMENT=OFF",
                         "-DRESPECT_INSTALL_PREFIX_CONFIG=ON"
    system "make"
    system "make", "install"
  end

  test do
    system "#{sbin}/zmap", "--version"
  end
end
