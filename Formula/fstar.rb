class Fstar < Formula
  desc "ML-like language aimed at program verification"
  homepage "https://www.fstar-lang.org/"
  url "https://github.com/FStarLang/FStar.git",
      :tag      => "v0.9.6.0",
      :revision => "743819b909b804f1234975d78809e18fd9ea0b99"
  head "https://github.com/FStarLang/FStar.git"



  depends_on "camlp4" => :build
  depends_on "ocamlbuild" => :build
  depends_on "opam" => :build
  depends_on "gmp"
  depends_on "ocaml"

  # FStar uses a special cutting-edge release from the Z3 team.
  # As we don't depend on the standard release we can't use the z3 formula.
  resource "z3" do
    url "https://github.com/Z3Prover/z3.git",
        :revision => "1f29cebd4df633a4fea50a29b80aa756ecd0e8e7"
  end

  def install
    ENV.deparallelize # Not related to F* : OCaml parallelization
    ENV["OPAMROOT"] = buildpath/"opamroot"
    ENV["OPAMYES"] = "1"

    # Avoid having to depend on coreutils
    inreplace "src/ocaml-output/Makefile", "$(DATE_EXEC) -Iseconds",
                                           "$(DATE_EXEC) '+%Y-%m-%dT%H:%M:%S%z'"

    resource("z3").stage do
      # F* warns if the Z3 git hash doesn't match
      githash = Utils.popen_read("git", "rev-parse", "--short=12", "HEAD").chomp
      system "python", "scripts/mk_make.py", "--prefix=#{libexec}",
             "--githash=#{githash}"
      cd "build" do
        system "make"
        system "make", "install"
      end
    end

    system "opam", "init", "--no-setup"
    system "opam", "config", "exec", "opam", "install",
           "ocamlfind", "batteries", "stdint", "zarith", "yojson", "fileutils",
           "pprint", "menhir", "ulex", "ppx_deriving", "ppx_deriving_yojson",
           "process"
    system "opam", "config", "exec", "--", "make", "-C", "src/ocaml-output"

    (libexec/"bin").install "bin/fstar.exe"
    (bin/"fstar.exe").write <<~EOS
      #!/bin/sh
      #{libexec}/bin/fstar.exe --smt #{libexec}/bin/z3 "$@"
    EOS

    (libexec/"ulib").install Dir["ulib/*"]
    (libexec/"contrib").install Dir["ucontrib/*"]
    (libexec/"examples").install Dir["examples/*"]
    (libexec/"tutorial").install Dir["doc/tutorial/*"]
    (libexec/"src").install Dir["src/*"]
    prefix.install "LICENSE-fsharp.txt"

    prefix.install_symlink libexec/"ulib"
    prefix.install_symlink libexec/"contrib"
    prefix.install_symlink libexec/"examples"
    prefix.install_symlink libexec/"tutorial"
    prefix.install_symlink libexec/"src"
  end

  def caveats; <<~EOS
    F* code can be extracted to OCaml code.
    To compile the generated OCaml code, you must install
    some packages from the OPAM package manager:
    - brew install opam
    - opam install batteries zarith yojson pprint stdint menhir

    F* code can be extracted to F# code.
    To compile the generated F# (.NET) code, you must install
    the 'mono' package that includes the fsharp compiler:
    - brew install mono
  EOS
  end

  test do
    system "#{bin}/fstar.exe",
           "#{prefix}/examples/algorithms/IntSort.fst",
           "#{prefix}/examples/algorithms/MergeSort.fst"
  end
end
