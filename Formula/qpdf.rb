class Qpdf < Formula
  desc "Tools for and transforming and inspecting PDF files"
  homepage "https://github.com/qpdf/qpdf"
  url "https://github.com/qpdf/qpdf/releases/download/release-qpdf-8.3.0/qpdf-8.3.0.tar.gz"
  sha256 "46c2a10690b86ba680db1c828e9ce44bb8e2993f69aa96d5a52fd1d98dc391f7"



  depends_on "jpeg"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/qpdf", "--version"
  end
end
