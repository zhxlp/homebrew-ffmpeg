class Rsnapshot < Formula
  desc "File system snapshot utility (based on rsync)"
  homepage "https://www.rsnapshot.org/"
  url "https://github.com/rsnapshot/rsnapshot/releases/download/1.4.2/rsnapshot-1.4.2.tar.gz"
  sha256 "042a81c45b325296b21c363f417985d857f083f87c5c27f5a64677a052f24e16"
  head "https://github.com/DrHyde/rsnapshot.git"



  def install
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make", "install"
  end

  test do
    system "#{bin}/rsnapshot", "--version"
  end
end
