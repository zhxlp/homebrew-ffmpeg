class ZeroInstall < Formula
  desc "Zero Install is a decentralised software installation system"
  homepage "https://0install.net/"
  url "https://downloads.sourceforge.net/project/zero-install/0install/2.13/0install-2.13.tar.bz2"
  sha256 "10726e05ac262c7c5dd1ae109deddf9aa61a146db8fc75c997dd4efc3a4d35ca"



  depends_on "camlp4" => :build
  depends_on "ocaml" => :build
  depends_on "ocamlbuild" => :build
  depends_on "opam" => :build
  depends_on "pkg-config" => :build
  depends_on "gnupg"

  def install
    ENV["OCAMLPARAM"] = "safe-string=0,_" # OCaml 4.06.0 compat
    ENV.append_path "PATH", Formula["gnupg"].opt_bin

    opamroot = buildpath/"opamroot"
    ENV["OPAMROOT"] = opamroot
    ENV["OPAMYES"] = "1"
    system "opam", "init", "--no-setup"
    modules = %w[
      cppo
      yojson
      xmlm
      ounit
      lwt_react
      ocurl
      obus
      sha
      cppo_ocamlbuild
    ]
    system "opam", "config", "exec", "opam", "install", *modules

    # mkdir: <buildpath>/build: File exists.
    # https://github.com/0install/0install/issues/87
    ENV.deparallelize { system "opam", "config", "exec", "make" }

    inreplace "dist/install.sh" do |s|
      s.gsub! '"/usr/local"', prefix
      s.gsub! '"${PREFIX}/man"', man
    end
    system "make", "install"
  end

  test do
    (testpath/"hello.py").write <<~EOS
      print("hello world")
    EOS
    (testpath/"hello.xml").write <<~EOS
      <?xml version="1.0" ?>
      <interface xmlns="http://zero-install.sourceforge.net/2004/injector/interface">
        <name>Hello</name>
        <summary>minimal demonstration program</summary>

        <implementation id="." version="0.1-pre">
          <command name='run' path='hello.py'>
            <runner interface='http://repo.roscidus.com/python/python'></runner>
          </command>
        </implementation>
      </interface>
    EOS
    assert_equal "hello world\n", shell_output("#{bin}/0launch --console hello.xml")
  end
end
