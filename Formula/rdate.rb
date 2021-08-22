class Rdate < Formula
  desc "Set the system's date from a remote host"
  homepage "https://www.aelius.com/njh/rdate/"
  url "https://www.aelius.com/njh/rdate/rdate-1.5.tar.gz"
  sha256 "6e800053eaac2b21ff4486ec42f0aca7214941c7e5fceedd593fa0be99b9227d"



  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    # note that the server must support RFC 868
    system "#{bin}/rdate", "-p", "-t", "10", "ptbtime1.ptb.de"
  end
end
