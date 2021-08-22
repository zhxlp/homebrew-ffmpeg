class Gpa < Formula
  desc "Graphical user interface for the GnuPG"
  homepage "https://www.gnupg.org/related_software/gpa/"
  url "https://gnupg.org/ftp/gcrypt/gpa/gpa-0.10.0.tar.bz2"
  mirror "https://deb.debian.org/debian/pool/main/g/gpa/gpa_0.10.0.orig.tar.bz2"
  sha256 "95dbabe75fa5c8dc47e3acf2df7a51cee096051e5a842b4c9b6d61e40a6177b1"



  depends_on "pkg-config" => :build
  depends_on "desktop-file-utils"
  depends_on "gpgme"
  depends_on "gtk+"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/gpa", "--version"
  end
end
