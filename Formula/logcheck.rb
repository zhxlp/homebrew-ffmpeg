class Logcheck < Formula
  desc "Mail anomalies in the system logfiles to the administrator"
  homepage "https://packages.debian.org/sid/logcheck"
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/l/logcheck/logcheck_1.3.19.tar.xz"
  mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/l/logcheck/logcheck_1.3.19.tar.xz"
  sha256 "06294c092b2115eca3d054c57778718c91dd2e0fd1c46650b7343c2a92672ca9"



  def install
    inreplace "Makefile", "$(DESTDIR)/$(CONFDIR)", "$(CONFDIR)"
    system "make", "install", "--always-make", "DESTDIR=#{prefix}",
                   "SBINDIR=sbin", "BINDIR=bin", "CONFDIR=#{etc}/logcheck"
  end

  test do
    (testpath/"README").write "Boaty McBoatface"
    output = shell_output("#{sbin}/logtail -f #{testpath}/README")
    assert_match "Boaty McBoatface", output
  end
end
