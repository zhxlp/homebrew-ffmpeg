class Dmenu < Formula
  desc "Dynamic menu for X11"
  homepage "https://tools.suckless.org/dmenu/"
  url "https://dl.suckless.org/tools/dmenu-4.8.tar.gz"
  sha256 "fe615a5c3607061e2106700862e82ac62a9fa1e6a7ac3d616a9c76106476db61"
  head "https://git.suckless.org/dmenu/", :using => :git



  depends_on :x11

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    assert_match /#{version}/, shell_output("#{bin}/dmenu -v")
  end
end
