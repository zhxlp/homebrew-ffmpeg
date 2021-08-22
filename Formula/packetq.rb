class Packetq < Formula
  desc "SQL-frontend to PCAP-files"
  homepage "https://www.dns-oarc.net/tools/packetq"
  url "https://www.dns-oarc.net/files/packetq/packetq-1.4.1.tar.gz"
  sha256 "de374930dcc36c4b23ef4807ac798016fef6f45d29d3464f993df21e154e57d1"



  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/packetq --csv -s 'select id from dns' -")
    assert_equal '"id"', output.chomp
  end
end
