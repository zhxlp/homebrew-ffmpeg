class RdiffBackup < Formula
  desc "Backs up one directory to another--also works over networks"
  homepage "https://www.nongnu.org/rdiff-backup/"
  url "https://savannah.nongnu.org/download/rdiff-backup/rdiff-backup-1.2.8.tar.gz"
  sha256 "0d91a85b40949116fa8aaf15da165c34a2d15449b3cbe01c8026391310ac95db"
  revision 1



  depends_on "librsync"

  # librsync 1.x support
  patch do
    url "https://git.archlinux.org/svntogit/community.git/plain/trunk/rdiff-backup-1.2.8-librsync-1.0.0.patch?h=packages/rdiff-backup"
    mirror "https://src.fedoraproject.org/cgit/rpms/rdiff-backup.git/plain/rdiff-backup-1.2.8-librsync-1.0.0.patch"
    sha256 "a00d993d5ffea32d58a73078fa20c90c1c1c6daa0587690cec0e3da43877bf12"
  end

  def install
    ENV["ARCHFLAGS"] = "-arch x86_64 -arch i386"
    system "python", "setup.py", "--librsync-dir=#{prefix}", "build"
    libexec.install Dir["build/lib.macosx*/rdiff_backup"]
    libexec.install Dir["build/scripts-*/*"]
    man1.install Dir["*.1"]
    bin.install_symlink Dir["#{libexec}/rdiff-backup*"]
  end

  test do
    system "#{bin}/rdiff-backup", "--version"
  end
end
