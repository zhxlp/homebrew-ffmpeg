class Surfraw < Formula
  desc "Shell Users' Revolutionary Front Rage Against the Web"
  homepage "https://packages.debian.org/sid/surfraw"
  url "https://ftp.openbsd.org/pub/OpenBSD/distfiles/surfraw-2.3.0.tar.gz"
  sha256 "ad0420583c8cdd84a31437e59536f8070f15ba4585598d82638b950e5c5c3625"



  def install
    system "./configure", "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--with-graphical-browser=open"
    system "make"
    ENV.deparallelize
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/surfraw -p duckduckgo homebrew")
    assert_equal "https://duckduckgo.com/lite/?q=homebrew", output.chomp
  end
end
