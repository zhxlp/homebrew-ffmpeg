class SphinxDoc < Formula
  include Language::Python::Virtualenv

  desc "Tool to create intelligent and beautiful documentation"
  homepage "https://www.sphinx-doc.org/"
  url "https://files.pythonhosted.org/packages/dd/f8/df628d41f42793d446285767164c6a8da71d82892f2c98c43e0523836d39/Sphinx-1.8.4.tar.gz"
  sha256 "c1c00fc4f6e8b101a0d037065043460dffc2d507257f2f11acaed71fd2b0c83c"



  keg_only <<~EOS
    this formula is mainly used internally by other formulae.
    Users are advised to use `pip` to install sphinx-doc
  EOS

  depends_on "python"

  def install
    system "pip3", "install", "Sphinx==1.8.4"
    venv = virtualenv_create(libexec, "python3")
    system "mkdir", "-p", bin/""
    # system "cp", "/usr/local/bin/sphinx-*", bin/""
    cp_r "/usr/local/bin/sphinx-apidoc", bin/""
    cp_r "/usr/local/bin/sphinx-autogen", bin/""
    cp_r "/usr/local/bin/sphinx-build", bin/""
    cp_r "/usr/local/bin/sphinx-quickstart", bin/""
  end

  test do
    system bin/"sphinx-quickstart", "-pPorject", "-aAuthor", "-v1.0", "-q", testpath
    system bin/"sphinx-build", testpath, testpath/"build"
    assert_predicate testpath/"build/index.html", :exist?
  end
end
