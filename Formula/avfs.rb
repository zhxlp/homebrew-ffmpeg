class Avfs < Formula
  desc "Virtual file system that facilitates looking inside archives"
  homepage "https://avf.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/avf/avfs/1.0.5/avfs-1.0.5.tar.bz2"
  sha256 "e5ce6b1f4193c37148b1b8a021f4f3d05e88f725cf11b16b95a58e8fdae50176"
  revision 1



  depends_on "pkg-config" => :build
  depends_on :macos => :sierra # needs clock_gettime
  depends_on "openssl"
  depends_on :osxfuse
  depends_on "xz"

  # Fix scripts to work on Mac OS X.
  # Nothing the patch fixes has been changed in 1.0.2, so still necessary.
  patch :DATA

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-fuse
      --enable-library
      --with-ssl=#{Formula["openssl"].opt_prefix}
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system bin/"avfsd", "--version"
  end
end

__END__
diff --git i/scripts/mountavfs w/scripts/mountavfs
index 5722dcd..a35e633 100755
--- i/scripts/mountavfs
+++ w/scripts/mountavfs
@@ -14,7 +14,7 @@ else
     MntDir=${HOME}/.avfs
 fi

-grep -qE "avfsd ${MntDir}" /proc/mounts || {
+grep -qE "avfsd.*${MntDir}" < <(mount) || {
    if [ ! -e "$MntDir" ]; then
       mkdir -p "$MntDir"
    fi
diff --git i/scripts/umountavfs w/scripts/umountavfs
index 09dc629..a242c21 100644
--- i/scripts/umountavfs
+++ w/scripts/umountavfs
@@ -14,11 +14,11 @@ else
     MntDir="${HOME}/.avfs"
 fi

-grep -qE "${MntDir}.*avfsd" /proc/mounts && {
+grep -qE "avfsd.*${MntDir}" < <(mount) && {
    echo unMounting AVFS on $MntDir...
    if type -p fusermount > /dev/null 2>&1 ; then
       fusermount -u -z "$MntDir"
    else
-      umount -l "$MntDir"
+      umount "$MntDir"
    fi
 }
