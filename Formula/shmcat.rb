class Shmcat < Formula
  desc "Tool that dumps shared memory segments (System V and POSIX)"
  homepage "https://shmcat.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/shmcat/shmcat-1.9.tar.xz"
  sha256 "831f1671e737bed31de3721b861f3796461ebf3b05270cf4c938749120ca8e5b"



  def install
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--disable-ftok",
                          "--disable-nls"
    system "make", "install"
  end

  test do
    assert_match /#{version}/, shell_output("#{bin}/shmcat --version")
  end
end
