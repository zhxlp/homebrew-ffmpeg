class Ipbt < Formula
  desc "Program for recording a UNIX terminal session"
  homepage "https://www.chiark.greenend.org.uk/~sgtatham/ipbt/"
  url "https://www.chiark.greenend.org.uk/~sgtatham/ipbt/ipbt-20170831.3c40fd3.tar.gz"
  mirror "https://dl.bintray.com/homebrew/mirror/ipbt-20170831.tar.gz"
  version "20170831"
  sha256 "237394f7074a8e540495bdcb8b82b5a932f8597505e2ee3ba3d96b0671cfeae3"



  def install
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking"
    system "make", "install"
  end

  test do
    system "#{bin}/ipbt"
  end
end
