class Tmpreaper < Formula
  desc "Clean up files in directories based on their age"
  homepage "https://packages.debian.org/sid/tmpreaper"
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/t/tmpreaper/tmpreaper_1.6.13+nmu1.tar.gz"
  mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/t/tmpreaper/tmpreaper_1.6.13+nmu1.tar.gz"
  version "1.6.13_nmu1"
  sha256 "c88f05b5d995b9544edb7aaf36ac5ce55c6fac2a4c21444e5dba655ad310b738"



  def install
    system "./configure", "--prefix=#{prefix}", "--sysconfdir=#{etc}"
    system "make", "install"
  end

  test do
    touch "removed"
    sleep 3
    touch "not-removed"
    system "#{sbin}/tmpreaper", "2s", "."
    refute_predicate testpath/"removed", :exist?
    assert_predicate testpath/"not-removed", :exist?
  end
end
