class IconNamingUtils < Formula
  desc "Script to handle icon names in desktop icon themes"
  homepage "https://specifications.freedesktop.org/icon-naming-spec/icon-naming-spec-latest.html"
  # Upstream seem to have enabled by default SSL/TLS across whole domain which
  # is problematic when the cert is for www rather than a wildcard or similar.
  # url "http://tango.freedesktop.org/releases/icon-naming-utils-0.8.90.tar.gz"
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/i/icon-naming-utils/icon-naming-utils_0.8.90.orig.tar.gz"
  mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/i/icon-naming-utils/icon-naming-utils_0.8.90.orig.tar.gz"
  sha256 "044ab2199ed8c6a55ce36fd4fcd8b8021a5e21f5bab028c0a7cdcf52a5902e1c"



  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
