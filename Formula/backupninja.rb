class Backupninja < Formula
  desc "Backup automation tool"
  homepage "https://0xacab.org/riseuplabs/backupninja"
  url "https://sourcearchive.raspbian.org/main/b/backupninja/backupninja_1.0.2.orig.tar.gz"
  mirror "https://debian.ethz.ch/ubuntu/ubuntu/pool/universe/b/backupninja/backupninja_1.0.2.orig.tar.gz"
  mirror "https://dl.bintray.com/homebrew/mirror/backupninja_1.0.2.orig.tar.gz"
  sha256 "fdb399de331493c8f959a784318349b19a01fbeece275da2ecd70ec9847a80b6"



  depends_on "dialog"
  depends_on "gawk"

  skip_clean "etc/backup.d"

  def install
    system "./configure", "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--localstatedir=#{var}"
    system "make", "install", "SED=sed"
  end

  def post_install
    (var/"log").mkpath
  end

  test do
    assert_match "root", shell_output("#{sbin}/backupninja -h", 1)
  end
end
