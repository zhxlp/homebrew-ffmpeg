class Leveldb < Formula
  desc "Key-value storage library with ordered mapping"
  homepage "https://github.com/google/leveldb/"
  url "https://github.com/google/leveldb/archive/v1.20.tar.gz"
  sha256 "f5abe8b5b209c2f36560b75f32ce61412f39a2922f7045ae764a2c23335b6664"
  revision 2



  depends_on "gperftools"
  depends_on "snappy"

  def install
    system "make"
    system "make", "check"

    include.install "include/leveldb"
    bin.install "out-static/leveldbutil"
    lib.install "out-static/libleveldb.a"
    lib.install "out-shared/libleveldb.dylib.1.20" => "libleveldb.1.20.dylib"
    lib.install_symlink lib/"libleveldb.1.20.dylib" => "libleveldb.dylib"
    lib.install_symlink lib/"libleveldb.1.20.dylib" => "libleveldb.1.dylib"
    MachO::Tools.change_dylib_id("#{lib}/libleveldb.1.dylib", "#{lib}/libleveldb.1.20.dylib")
  end

  test do
    assert_match "dump files", shell_output("#{bin}/leveldbutil 2>&1", 1)
  end
end
