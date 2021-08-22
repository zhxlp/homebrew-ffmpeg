class Eventlog < Formula
  desc "Replacement for syslog API providing structure to messages"
  homepage "https://my.balabit.com/downloads/eventlog/"
  url "https://my.balabit.com/downloads/syslog-ng/sources/3.4.3/source/eventlog_0.2.13.tar.gz"
  mirror "https://src.fedoraproject.org/lookaside/extras/eventlog/eventlog_0.2.13.tar.gz/68ec8d1ea3b98fa35002bb756227c315/eventlog_0.2.13.tar.gz"
  sha256 "7cb4e6f316daede4fa54547371d5c986395177c12dbdec74a66298e684ac8b85"



  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
