class Vttest < Formula
  desc "Test compatibility of VT100-compatible terminals"
  homepage "https://invisible-island.net/vttest/"
  url "https://invisible-mirror.net/archives/vttest/vttest-20140305.tgz"
  sha256 "0168aa34061d4470a68b0dd0781a2a9e2bbfb1493e540c99f615b867a11cbf83"



  def install
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make"
    system "make", "install"
  end

  test do
    assert_predicate bin/"vttest", :exist?
  end
end
