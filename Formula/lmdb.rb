class Lmdb < Formula
  desc "Lightning memory-mapped database: key-value data store"
  homepage "https://symas.com/mdb-and-sqlite/"
  url "https://github.com/LMDB/lmdb/archive/LMDB_0.9.23.tar.gz"
  sha256 "abf42e91f046787ed642d9eb21812a5c473f3ba5854124484d16eadbe0aa9c81"
  version_scheme 1
  head "https://github.com/LMDB/lmdb.git", :branch => "mdb.master"



  def install
    cd "libraries/liblmdb" do
      system "make", "SOEXT=.dylib"
      system "make", "test", "SOEXT=.dylib"
      system "make", "install", "SOEXT=.dylib", "prefix=#{prefix}"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mdb_dump -V")
  end
end
