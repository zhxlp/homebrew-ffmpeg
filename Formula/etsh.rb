class Etsh < Formula
  desc "Two ports of /bin/sh from V6 UNIX (circa 1975)"
  homepage "https://etsh.io/"
  url "https://etsh.io/src/etsh-5.2.0.tar.gz"
  sha256 "af561b7fa2f9eb872e2e5a71a8f8e5479f8bb5829a8ec1534f0240475c3dfe5e"
  version_scheme 1
  head "https://github.com/JNeitzel/v6shell.git", :branch => "current"



  conflicts_with "teleport", :because => "both install `tsh` binaries"

  def install
    system "./configure"
    system "make", "install", "PREFIX=#{prefix}", "SYSCONFDIR=#{etc}", "MANDIR=#{man1}"
    bin.install_symlink "etsh" => "osh"
    bin.install_symlink "tsh" => "sh6"
  end

  test do
    assert_match "brew!", shell_output("#{bin}/etsh -c 'echo brew!'").strip
  end
end
