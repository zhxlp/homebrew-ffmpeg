class A2ps < Formula
  desc "Any-to-PostScript filter"
  homepage "https://www.gnu.org/software/a2ps/"
  url "https://ftp.gnu.org/gnu/a2ps/a2ps-4.14.tar.gz"
  mirror "https://ftpmirror.gnu.org/a2ps/a2ps-4.14.tar.gz"
  sha256 "f3ae8d3d4564a41b6e2a21f237d2f2b104f48108591e8b83497500182a3ab3a4"



  pour_bottle? do
    reason "The bottle needs to be installed into /usr/local."
    # https://github.com/Homebrew/brew/issues/2005
    satisfy { HOMEBREW_PREFIX.to_s == "/usr/local" }
  end

  # Software was last updated in 2007.
  # https://svn.macports.org/ticket/20867
  # https://trac.macports.org/ticket/18255
  patch :p0 do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/0ae366e6/a2ps/patch-contrib_sample_Makefile.in"
    sha256 "5a34c101feb00cf52199a28b1ea1bca83608cf0a1cb123e6af2d3d8992c6011f"
  end

  patch :p0 do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/0ae366e6/a2ps/patch-lib__xstrrpl.c"
    sha256 "89fa3c95c329ec326e2e76493471a7a974c673792725059ef121e6f9efb05bf4"
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--sysconfdir=#{etc}",
                          "--with-lispdir=#{elisp}"
    system "make", "install"
  end

  test do
    (testpath/"test.txt").write("Hello World!\n")
    system bin/"a2ps", "test.txt", "-o", "test.ps"
    assert File.read("test.ps").start_with?("")
  end
end
