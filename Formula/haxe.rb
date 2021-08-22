class Haxe < Formula
  desc "Multi-platform programming language"
  homepage "https://haxe.org/"
  url "https://github.com/HaxeFoundation/haxe.git",
      :tag      => "3.4.7",
      :revision => "bb7b827a9c135fbfd066da94109a728351b87b92"



  head do
    url "https://github.com/HaxeFoundation/haxe.git", :branch => "development"

    depends_on "aspcud" => :build
    depends_on "opam" => :build
    depends_on "pkg-config" => :build
  end

  depends_on "camlp4" => :build
  depends_on "cmake" => :build
  depends_on "ocaml" => :build
  depends_on "neko"
  depends_on "pcre"

  def install
    ENV["OCAMLPARAM"] = "safe-string=0,_" # OCaml 4.06.0 compat

    # Build requires targets to be built in specific order
    ENV.deparallelize

    if build.head?
      Dir.mktmpdir("opamroot") do |opamroot|
        ENV["OPAMROOT"] = opamroot
        ENV["OPAMYES"] = "1"
        system "opam", "init", "--no-setup"
        system "opam", "config", "exec", "--",
               "opam", "pin", "add", "haxe", buildpath, "--no-action"
        system "opam", "config", "exec", "--",
               "opam", "install", "haxe", "--deps-only"
        system "opam", "config", "exec", "--",
               "make", "ADD_REVISION=1"
      end
    else
      system "make", "OCAMLOPT=ocamlopt.opt"
    end

    # Rebuild haxelib as a valid binary
    cd "extra/haxelib_src" do
      system "cmake", "."
      system "make"
    end
    rm "haxelib"
    cp "extra/haxelib_src/haxelib", "haxelib"

    bin.mkpath
    system "make", "install", "INSTALL_BIN_DIR=#{bin}",
           "INSTALL_LIB_DIR=#{lib}/haxe", "INSTALL_STD_DIR=#{lib}/haxe/std"
  end

  def caveats; <<~EOS
    Add the following line to your .bashrc or equivalent:
      export HAXE_STD_PATH="#{HOMEBREW_PREFIX}/lib/haxe/std"
  EOS
  end

  test do
    ENV["HAXE_STD_PATH"] = "#{HOMEBREW_PREFIX}/lib/haxe/std"
    system "#{bin}/haxe", "-v", "Std"
    system "#{bin}/haxelib", "version"
  end
end
