class ProxychainsNg < Formula
  desc "Hook preloader"
  homepage "https://sourceforge.net/projects/proxychains-ng/"
  url "https://github.com/rofl0r/proxychains-ng/archive/v4.13.tar.gz"
  sha256 "ff15295efc227fec99c2b8131ad532e83e833a02470c7a48ae7e7f131e1b08bc"
  head "https://github.com/rofl0r/proxychains-ng.git"



  def install
    system "./configure", "--prefix=#{prefix}", "--sysconfdir=#{etc}"
    system "make"
    system "make", "install"
    system "make", "install-config"
  end

  test do
    assert_match "config file found", shell_output("#{bin}/proxychains4 test 2>&1", 1)
  end
end
