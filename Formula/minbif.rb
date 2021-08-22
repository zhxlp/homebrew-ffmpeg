class Minbif < Formula
  desc "IRC-to-other-IM-networks gateway using Pidgin library"
  homepage "https://symlink.me/projects/minbif/wiki/"
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/m/minbif/minbif_1.0.5+git20150505.orig.tar.gz"
  mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/m/minbif/minbif_1.0.5+git20150505.orig.tar.gz"
  version "1.0.5-20150505"
  sha256 "4e264fce518a0281de9fc3d44450677c5fa91097a0597ef7a0d2a688ee66d40b"
  revision 2



  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "glib"
  depends_on "gnutls"
  depends_on "pidgin"

  def install
    inreplace "minbif.conf" do |s|
      s.gsub! "users = /var", "users = #{var}"
      s.gsub! "motd = /etc", "motd = #{etc}"
    end

    system "make", "PREFIX=#{prefix}",
                   "ENABLE_CACA=OFF",
                   "ENABLE_IMLIB=OFF",
                   "ENABLE_MINBIF=ON",
                   "ENABLE_PAM=OFF",
                   "ENABLE_PLUGIN=ON",
                   "ENABLE_TLS=ON",
                   "ENABLE_VIDEO=OFF"
    system "make", "install"

    (var/"lib/minbif/users").mkpath
  end

  def caveats; <<~EOS
    Minbif must be passed its config as first argument:
        minbif #{etc}/minbif/minbif.conf

    Learn more about minbif: https://symlink.me/projects/minbif/wiki/Quick_start
  EOS
  end

  test do
    system "#{bin}/minbif", "--version"
  end
end
