class Smake < Formula
  desc "Portable make program with automake features"
  homepage "https://s-make.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/s-make/smake-1.2.5.tar.bz2"
  sha256 "27566aa731a400c791cd95361cc755288b44ff659fa879933d4ea35d052259d4"



  def install
    # The bootstrap smake does not like -j
    ENV.deparallelize
    # Xcode 9 miscompiles smake if optimization is enabled
    # https://sourceforge.net/p/schilytools/tickets/2/
    ENV.O1 if DevelopmentTools.clang_build_version >= 900

    system "make", "GMAKE_NOWARN=true", "INS_BASE=#{libexec}", "INS_RBASE=#{libexec}", "install"
    bin.install_symlink libexec/"bin/smake"
    man1.install_symlink Dir["#{libexec}/share/man/man1/*.1"]
    man5.install_symlink Dir["#{libexec}/share/man/man5/*.5"]
  end

  test do
    system "#{bin}/smake", "-version"
  end
end
