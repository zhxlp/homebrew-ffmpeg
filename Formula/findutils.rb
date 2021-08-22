class Findutils < Formula
  desc "Collection of GNU find, xargs, and locate"
  homepage "https://www.gnu.org/software/findutils/"
  url "https://ftp.gnu.org/gnu/findutils/findutils-4.6.0.tar.gz"
  mirror "https://ftpmirror.gnu.org/findutils/findutils-4.6.0.tar.gz"
  sha256 "ded4c9f73731cd48fec3b6bdaccce896473b6d8e337e9612e16cf1431bb1169d"



  def install
    # Work around unremovable, nested dirs bug that affects lots of
    # GNU projects. See:
    # https://github.com/Homebrew/homebrew/issues/45273
    # https://github.com/Homebrew/homebrew/issues/44993
    # This is thought to be an el_capitan bug:
    # https://lists.gnu.org/archive/html/bug-tar/2015-10/msg00017.html
    ENV["gl_cv_func_getcwd_abort_bug"] = "no" if MacOS.version == :el_capitan

    args = %W[
      --prefix=#{prefix}
      --localstatedir=#{var}/locate
      --disable-dependency-tracking
      --disable-debug
      --program-prefix=g
    ]

    system "./configure", *args
    system "make", "install"

    # https://savannah.gnu.org/bugs/index.php?46846
    # https://github.com/Homebrew/homebrew/issues/47791
    (libexec/"bin").install bin/"gupdatedb"
    (bin/"gupdatedb").write <<~EOS
      #!/bin/sh
      export LC_ALL='C'
      exec "#{libexec}/bin/gupdatedb" "$@"
    EOS

    [[prefix, bin], [share, man/"*"]].each do |base, path|
      Dir[path/"g*"].each do |p|
        f = Pathname.new(p)
        gnupath = "gnu" + f.relative_path_from(base).dirname
        (libexec/gnupath).install_symlink f => f.basename.sub(/^g/, "")
      end
    end

    libexec.install_symlink "gnuman" => "man"
  end

  def post_install
    (var/"locate").mkpath
  end

  def caveats; <<~EOS
    All commands have been installed with the prefix "g".
    If you need to use these commands with their normal names, you
    can add a "gnubin" directory to your PATH from your bashrc like:
      PATH="#{opt_libexec}/gnubin:$PATH"
  EOS
  end

  test do
    touch "HOMEBREW"
    assert_match "HOMEBREW", shell_output("#{bin}/gfind .")
    assert_match "HOMEBREW", shell_output("#{opt_libexec}/gnubin/find .")
  end
end
