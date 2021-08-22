class Urlview < Formula
  desc "URL extractor/launcher"
  homepage "https://packages.debian.org/sid/misc/urlview"
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/u/urlview/urlview_0.9.orig.tar.gz"
  mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/u/urlview/urlview_0.9.orig.tar.gz"
  version "0.9-20"
  sha256 "746ff540ccf601645f500ee7743f443caf987d6380e61e5249fc15f7a455ed42"



  patch do
    url "https://mirrors.ocf.berkeley.edu/debian/pool/main/u/urlview/urlview_0.9-20.diff.gz"
    mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/u/urlview/urlview_0.9-20.diff.gz"
    sha256 "0707956fd7195aefe6d6ff2eaabe8946e3d18821a1ce97c0f48d0f8d6e37514e"
  end

  def install
    inreplace "urlview.man", "/etc/urlview/url_handler.sh", "open"
    inreplace "urlview.c",
      '#define DEFAULT_COMMAND "/etc/urlview/url_handler.sh %s"',
      '#define DEFAULT_COMMAND "open %s"'

    man1.mkpath
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}"
    system "make", "install"
  end
end
