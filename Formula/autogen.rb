class Autogen < Formula
  desc "Automated text file generator"
  homepage "https://autogen.sourceforge.io"
  url "https://ftp.gnu.org/gnu/autogen/rel5.18.12/autogen-5.18.12.tar.xz"
  mirror "https://ftpmirror.gnu.org/autogen/rel5.18.12/autogen-5.18.12.tar.xz"
  sha256 "be3ba62e883185b6ee8475edae97d7197d701d6b9ad9c3d2df53697110c1bfd8"
  revision 1



  depends_on "pkg-config" => :build
  depends_on "guile"

  # Allow guile 2.2 to be used
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/0de886b/autogen/allow-guile-2.2.diff"
    sha256 "438fe673432c96d5da449b84daa4d1c6ad238ea0b4ccd13491872df8c51fa978"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"

    # make and install must be separate steps for this formula
    system "make"
    system "make", "install"
  end

  test do
    system bin/"autogen", "-v"
  end
end
