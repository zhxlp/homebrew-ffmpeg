class Ncurses < Formula
  desc "Text-based UI library"
  homepage "https://www.gnu.org/software/ncurses/"
  url "https://ftp.gnu.org/gnu/ncurses/ncurses-6.1.tar.gz"
  mirror "https://ftpmirror.gnu.org/ncurses/ncurses-6.1.tar.gz"
  sha256 "aa057eeeb4a14d470101eff4597d5833dcef5965331be3528c08d99cebaa0d17"



  keg_only :provided_by_macos

  depends_on "pkg-config" => :build

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--enable-pc-files",
                          "--with-pkg-config-libdir=#{lib}/pkgconfig",
                          "--enable-sigwinch",
                          "--enable-symlinks",
                          "--enable-widec",
                          "--with-shared",
                          "--with-gpm=no"
    system "make", "install"
    make_libncurses_symlinks

    prefix.install "test"
    (prefix/"test").install "install-sh", "config.sub", "config.guess"
  end

  def make_libncurses_symlinks
    major = version.to_s.split(".")[0]

    %w[form menu ncurses panel].each do |name|
      lib.install_symlink "lib#{name}w.#{major}.dylib" => "lib#{name}.dylib"
      lib.install_symlink "lib#{name}w.#{major}.dylib" => "lib#{name}.#{major}.dylib"
      lib.install_symlink "lib#{name}w.a" => "lib#{name}.a"
      lib.install_symlink "lib#{name}w_g.a" => "lib#{name}_g.a"
    end

    lib.install_symlink "libncurses++w.a" => "libncurses++.a"
    lib.install_symlink "libncurses.a" => "libcurses.a"
    lib.install_symlink "libncurses.dylib" => "libcurses.dylib"

    (lib/"pkgconfig").install_symlink "ncursesw.pc" => "ncurses.pc"

    bin.install_symlink "ncursesw#{major}-config" => "ncurses#{major}-config"

    include.install_symlink [
      "ncursesw/curses.h", "ncursesw/form.h", "ncursesw/ncurses.h",
      "ncursesw/panel.h", "ncursesw/term.h", "ncursesw/termcap.h"
    ]
  end

  test do
    ENV["TERM"] = "xterm"

    system prefix/"test/configure", "--prefix=#{testpath}/test",
                                    "--with-curses-dir=#{prefix}"
    system "make", "install"

    system testpath/"test/bin/keynames"
    system testpath/"test/bin/test_arrays"
    system testpath/"test/bin/test_vidputs"
  end
end
