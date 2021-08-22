class Libgit2Glib < Formula
  desc "Glib wrapper library around libgit2 git access library"
  homepage "https://github.com/GNOME/libgit2-glib"
  url "https://download.gnome.org/sources/libgit2-glib/0.27/libgit2-glib-0.27.7.tar.xz"
  sha256 "1131df6d45e405756ef2d9b7613354d542ce99883f6a89582d6236d01bd2efc2"
  head "https://github.com/GNOME/libgit2-glib.git"



  depends_on "gobject-introspection" => :build
  depends_on "meson-internal" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "python" => :build
  depends_on "vala" => :build
  depends_on "gettext"
  depends_on "glib"
  depends_on "libgit2"

  def install
    ENV.refurbish_args

    # Fix "ld: unknown option: -Bsymbolic-functions"
    # Reported 2 Apr 2018 https://bugzilla.gnome.org/show_bug.cgi?id=794889
    inreplace "libgit2-glib/meson.build",
              "libgit2_glib_link_args = [ '-Wl,-Bsymbolic-functions' ]",
              "libgit2_glib_link_args = []"

    mkdir "build" do
      system "meson", "--prefix=#{prefix}",
                      "-Dpython=false",
                      "-Dvapi=true",
                      ".."
      system "ninja"
      system "ninja", "install"
      libexec.install Dir["examples/*"]
    end
  end

  test do
    mkdir "horatio" do
      system "git", "init"
    end
    system "#{libexec}/general", testpath/"horatio"
  end
end
