class Virtualpg < Formula
  desc "Loadable dynamic extension for SQLite and SpatiaLite"
  homepage "https://www.gaia-gis.it/fossil/virtualpg/index"
  url "https://www.gaia-gis.it/gaia-sins/virtualpg-1.0.2.tar.gz"
  sha256 "37abd56b2899c90b355e50d843ba019af540b83e7af1da110a766f041abb514e"



  depends_on "libspatialite"
  depends_on "postgis"

  def install
    # New SQLite3 extension won't load via SELECT load_extension('mod_virtualpg');
    # unless named mod_virtualpg.dylib (should actually be mod_virtualpg.bundle)
    # See: https://groups.google.com/forum/#!topic/spatialite-users/EqJAB8FYRdI
    # needs upstream fixes in both SQLite and libtool
    inreplace "configure",
    "shrext_cmds='`test .$module = .yes && echo .so || echo .dylib`'",
    "shrext_cmds='.dylib'"

    system "./configure", "--enable-shared=yes",
                          "--disable-dependency-tracking",
                          "--with-pgconfig=#{Formula["postgresql"].opt_bin}/pg_config",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    # Verify mod_virtualpg extension can be loaded using Homebrew's SQLite
    system "echo", "\" SELECT load_extension('#{opt_lib}/mod_virtualpg');\" | #{Formula["sqlite"].opt_bin}/sqlite3"
  end
end
