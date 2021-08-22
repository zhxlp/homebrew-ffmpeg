class Ddrescue < Formula
  desc "GNU data recovery tool"
  homepage "https://www.gnu.org/software/ddrescue/ddrescue.html"
  url "https://ftp.gnu.org/gnu/ddrescue/ddrescue-1.23.tar.lz"
  mirror "https://ftpmirror.gnu.org/ddrescue/ddrescue-1.23.tar.lz"
  sha256 "a9ae2dd44592bf386c9c156a5dacaeeb901573c9867ada3608f887d401338d8d"



  def install
    system "./configure", "--prefix=#{prefix}",
                          "CXX=#{ENV.cxx}"
    system "make", "install"
  end

  test do
    system bin/"ddrescue", "--force", "--size=64Ki", "/dev/zero", "/dev/null"
  end
end
