class Unyaffs < Formula
  desc "Extract files from a YAFFS2 filesystem image"
  homepage "https://github.com/ehlers/unyaffs"
  url "https://github.com/ehlers/unyaffs/archive/0.9.7.tar.gz"
  sha256 "099ee9e51046b83fe8555d7a6284f6fe4fbae96be91404f770443d8129bd8775"
  head "https://github.com/ehlers/unyaffs.git"



  def install
    system "make"
    bin.install "unyaffs"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/unyaffs -V")
  end
end
