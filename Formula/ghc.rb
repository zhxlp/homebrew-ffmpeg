require "language/haskell"

class Ghc < Formula
  include Language::Haskell::Cabal

  desc "Glorious Glasgow Haskell Compilation System"
  homepage "https://haskell.org/ghc/"
  url "https://downloads.haskell.org/~ghc/8.4.4/ghc-8.4.4-src.tar.xz"
  sha256 "11117735a58e507c481c09f3f39ae5a314e9fbf49fc3109528f99ea7959004b2"



  head do
    url "https://git.haskell.org/ghc.git", :branch => "ghc-8.4"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build

    resource "cabal" do
      url "https://hackage.haskell.org/package/cabal-install-2.4.0.0/cabal-install-2.4.0.0.tar.gz"
      sha256 "1329e9564b736b0cfba76d396204d95569f080e7c54fe355b6d9618e3aa0bef6"
    end
  end

  depends_on "python" => :build
  depends_on "sphinx-doc" => :build

  resource "gmp" do
    url "https://ftp.gnu.org/gnu/gmp/gmp-6.1.2.tar.xz"
    mirror "https://gmplib.org/download/gmp/gmp-6.1.2.tar.xz"
    mirror "https://ftpmirror.gnu.org/gmp/gmp-6.1.2.tar.xz"
    sha256 "87b565e89a9a684fe4ebeeddb8399dce2599f9c9049854ca8c0dfbdea0e21912"
  end

  # https://www.haskell.org/ghc/download_ghc_8_0_1#macosx_x86_64
  # "This is a distribution for Mac OS X, 10.7 or later."
  resource "binary" do
    url "https://downloads.haskell.org/~ghc/8.4.4/ghc-8.4.4-x86_64-apple-darwin.tar.xz"
    sha256 "28dc89ebd231335337c656f4c5ead2ae2a1acc166aafe74a14f084393c5ef03a"
  end

  resource "testsuite" do
    url "https://downloads.haskell.org/~ghc/8.4.4/ghc-8.4.4-testsuite.tar.xz"
    sha256 "46babc7629c9bce58204d6425e3726e35aa8dc58a8c4a7e44dc81ed975721469"
  end

  patch :DATA

  def install
    ENV["CC"] = ENV.cc
    ENV["LD"] = "ld"

    # Build a static gmp rather than in-tree gmp, otherwise all ghc-compiled
    # executables link to Homebrew's GMP.
    gmp = libexec/"integer-gmp"

    # GMP *does not* use PIC by default without shared libs  so --with-pic
    # is mandatory or else you'll get "illegal text relocs" errors.
    resource("gmp").stage do
      system "./configure", "--prefix=#{gmp}", "--with-pic", "--disable-shared",
                            "--build=#{Hardware.oldest_cpu}-apple-darwin#{`uname -r`.to_i}"
      system "make"
      system "make", "check"
      ENV.deparallelize { system "make", "install" }
    end

    args = ["--with-gmp-includes=#{gmp}/include",
            "--with-gmp-libraries=#{gmp}/lib"]

    # As of Xcode 7.3 (and the corresponding CLT) `nm` is a symlink to `llvm-nm`
    # and the old `nm` is renamed `nm-classic`. Building with the new `nm`, a
    # segfault occurs with the following error:
    #   make[1]: * [compiler/stage2/dll-split.stamp] Segmentation fault: 11
    # Upstream is aware of the issue and is recommending the use of nm-classic
    # until Apple restores POSIX compliance:
    # https://ghc.haskell.org/trac/ghc/ticket/11744
    # https://ghc.haskell.org/trac/ghc/ticket/11823
    # https://mail.haskell.org/pipermail/ghc-devs/2016-April/011862.html
    # LLVM itself has already fixed the bug: llvm-mirror/llvm@ae7cf585
    # rdar://25311883 and rdar://25299678
    if DevelopmentTools.clang_build_version >= 703 && DevelopmentTools.clang_build_version < 800
      args << "--with-nm=#{`xcrun --find nm-classic`.chomp}"
    end

    resource("binary").stage do
      binary = buildpath/"binary"

      system "./configure", "--prefix=#{binary}", *args
      ENV.deparallelize { system "make", "install" }

      ENV.prepend_path "PATH", binary/"bin"
    end

    if build.head?
      resource("cabal").stage do
        system "sh", "bootstrap.sh", "--sandbox"
        (buildpath/"bootstrap-tools/bin").install ".cabal-sandbox/bin/cabal"
      end

      ENV.prepend_path "PATH", buildpath/"bootstrap-tools/bin"

      cabal_sandbox do
        cabal_install "--only-dependencies", "happy", "alex"
        cabal_install "--prefix=#{buildpath}/bootstrap-tools", "happy", "alex"
      end

      system "./boot"
    end

    system "./configure", "--prefix=#{prefix}", *args
    system "make"

    resource("testsuite").stage { buildpath.install Dir["*"] }
    cd "testsuite" do
      system "make", "clean"
      system "make", "CLEANUP=1", "THREADS=#{ENV.make_jobs}", "fast"
    end

    ENV.deparallelize { system "make", "install" }
    Dir.glob(lib/"*/package.conf.d/package.cache") { |f| rm f }
  end

  def post_install
    system "#{bin}/ghc-pkg", "recache"
  end

  test do
    (testpath/"hello.hs").write('main = putStrLn "Hello Homebrew"')
    system "#{bin}/runghc", testpath/"hello.hs"
  end
end

__END__

diff --git a/docs/users_guide/flags.py b/docs/users_guide/flags.py
index cc30b8c066..21c7ae3a16 100644
--- a/docs/users_guide/flags.py
+++ b/docs/users_guide/flags.py
@@ -46,9 +46,11 @@

 from docutils import nodes
 from docutils.parsers.rst import Directive, directives
+import sphinx
 from sphinx import addnodes
 from sphinx.domains.std import GenericObject
 from sphinx.errors import SphinxError
+from distutils.version import LooseVersion
 from utils import build_table_from_list

 ### Settings
@@ -597,14 +599,18 @@ def purge_flags(app, env, docname):
 ### Initialization

 def setup(app):
+    # The override argument to add_directive_to_domain is only supported by >= 1.8
+    sphinx_version = LooseVersion(sphinx.__version__)
+    override_arg = {'override': True} if sphinx_version >= LooseVersion('1.8') else {}

     # Add ghc-flag directive, and override the class with our own
     app.add_object_type('ghc-flag', 'ghc-flag')
-    app.add_directive_to_domain('std', 'ghc-flag', Flag)
+    app.add_directive_to_domain('std', 'ghc-flag', Flag, **override_arg)

     # Add extension directive, and override the class with our own
     app.add_object_type('extension', 'extension')
-    app.add_directive_to_domain('std', 'extension', LanguageExtension)
+    app.add_directive_to_domain('std', 'extension', LanguageExtension,
+                                **override_arg)
     # NB: language-extension would be misinterpreted by sphinx, and produce
     # lang="extensions" XML attributes
