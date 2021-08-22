class Dosfstools < Formula
  desc "Tools to create, check and label file systems of the FAT family"
  homepage "https://github.com/dosfstools"
  head "https://github.com/dosfstools/dosfstools.git"

  stable do
    url "https://github.com/dosfstools/dosfstools/releases/download/v4.1/dosfstools-4.1.tar.gz"
    sha256 "dc49997fd9fcd6e550c1a0dd5f97863d6ded99d465c33633a2b8769f4d72a137"

    # This patch restores the old defaults in versions up to v3.0.28
    patch do
      url "https://github.com/dosfstools/dosfstools/commit/1e76e577.patch?full_index=1"
      sha256 "7dafc9e5642f8c1f316ac9dedbc0e4becf198b582b255b53bdf45b8de84bf6b6"
    end
  end


  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build

  def install
    system "autoreconf", "-f", "-i"
    system "./configure", "--prefix=#{prefix}", "--without-udev",
                          "--enable-compat-symlinks"
    system "make", "install"
  end

  test do
    system "dd", "if=/dev/zero", "of=test.bin", "bs=512", "count=1024"
    system "#{sbin}/mkfs.fat", "test.bin", "-n HOMEBREW", "-v"
    system "#{sbin}/fatlabel", "test.bin"
    system "#{sbin}/fsck.fat", "-v", "test.bin"
  end
end
