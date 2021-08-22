class GnuGetopt < Formula
  desc "Command-line option parsing library"
  homepage "http://frodo.looijaard.name/project/getopt"
  url "http://frodo.looijaard.name/system/files/software/getopt/getopt-1.1.6.tar.gz"
  mirror "https://distfiles.macports.org/getopt/getopt-1.1.6.tar.gz"
  mirror "https://fossies.org/linux/misc/getopt-1.1.6.tar.gz"
  sha256 "d0bf1dc642a993e7388a1cddfb9409bed375c21d5278056ccca3a0acd09dc5fe"



  keg_only :provided_by_macos

  depends_on "gettext"

  def install
    inreplace "Makefile" do |s|
      gettext = Formula["gettext"]
      s.change_make_var! "CPPFLAGS", "\\1 -I#{gettext.include}"
      s.change_make_var! "LDFLAGS", "\\1 -L#{gettext.lib} -lintl"
    end
    system "make", "prefix=#{prefix}", "mandir=#{man}", "install"
  end

  test do
    system "#{bin}/getopt", "-o", "--test"
  end
end
