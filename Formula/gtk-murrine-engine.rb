class GtkMurrineEngine < Formula
  desc "Murrine GTK+ engine"
  homepage "https://github.com/GNOME/murrine"
  url "https://download.gnome.org/sources/murrine/0.98/murrine-0.98.2.tar.xz"
  sha256 "e9c68ae001b9130d0f9d1b311e8121a94e5c134b82553ba03971088e57d12c89"
  revision 2



  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "gtk+"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-animation"
    system "make", "install"
  end

  test do
    assert_predicate lib/"gtk-2.0/2.10.0/engines/libmurrine.so", :exist?
    assert_predicate share/"gtk-engines/murrine.xml", :exist?
  end
end
