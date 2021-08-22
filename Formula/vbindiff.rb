class Vbindiff < Formula
  desc "Visual Binary Diff"
  homepage "https://www.cjmweb.net/vbindiff/"
  url "https://www.cjmweb.net/vbindiff/vbindiff-3.0_beta5.tar.gz"
  sha256 "f04da97de993caf8b068dcb57f9de5a4e7e9641dc6c47f79b60b8138259133b8"



  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/vbindiff", "-L"
  end
end
