class OcamlFindlib < Formula
  desc "OCaml library manager"
  homepage "http://projects.camlcity.org/projects/findlib.html"
  url "http://download.camlcity.org/download/findlib-1.8.0.tar.gz"
  sha256 "2b7b7d6d65bb0f3f8a2c51c63c02b0bcf1fea4c23513f866140dc7dc24fe27ad"



  depends_on "ocaml"

  def install
    # See https://gitlab.camlcity.org/gerd/lib-findlib/merge_requests/8
    ENV.deparallelize

    system "./configure", "-bindir", bin,
                          "-mandir", man,
                          "-sitelib", lib/"ocaml",
                          "-config", etc/"findlib.conf",
                          "-no-topfind"
    system "make", "all"
    system "make", "opt"
    inreplace "findlib.conf", prefix, HOMEBREW_PREFIX
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/ocamlfind query findlib")
    assert_equal "#{HOMEBREW_PREFIX}/lib/ocaml/findlib", output.chomp
  end
end
