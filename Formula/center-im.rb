class CenterIm < Formula
  desc "Text-mode multi-protocol instant messaging client"
  homepage "https://www.centerim.org/index.php/Main_Page"
  url "https://www.centerim.org/download/releases/centerim-4.22.10.tar.gz"
  sha256 "93ce15eb9c834a4939b5aa0846d5c6023ec2953214daf8dc26c85ceaa4413f6e"
  revision 1



  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "openssl"

  # Fix build with clang; 4.22.10 is an outdated release and 5.0 is a rewrite,
  # so this is not reported upstream
  patch :DATA

  patch :p0 do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/677cb38/center-im/patch-libjabber_jconn.c.diff"
    sha256 "ed8d10075c23c7dec2a782214cb53be05b11c04e617350f6f559f3c3bf803cfe"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-msn",
                          "--with-openssl=#{Formula["openssl"].opt_prefix}"
    system "make", "install"

    # /bin/gawk does not exist on macOS
    inreplace bin/"cimformathistory", "/bin/gawk", "/usr/bin/awk"
  end

  test do
    assert_match /trillian/, shell_output("#{bin}/cimconv")
  end
end

__END__
diff --git a/libicq2000/libicq2000/sigslot.h b/libicq2000/libicq2000/sigslot.h
index b7509c0..024774f 100644
--- a/libicq2000/libicq2000/sigslot.h
+++ b/libicq2000/libicq2000/sigslot.h
@@ -82,6 +82,7 @@
 #ifndef SIGSLOT_H__
 #define SIGSLOT_H__

+#include <cstdlib>
 #include <set>
 #include <list>
