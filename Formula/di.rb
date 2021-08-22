class Di < Formula
  desc "Advanced df-like disk information utility"
  homepage "https://gentoo.com/di/"
  url "https://gentoo.com/di/di-4.47.tar.gz"
  sha256 "b5031c1f3b98536eee95fb91634fe700cec5e08a3cf38e14fffc47f969bf8a7e"



  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    system "#{bin}/di"
  end
end
