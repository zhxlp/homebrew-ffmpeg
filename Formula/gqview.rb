class Gqview < Formula
  desc "Image browser"
  homepage "https://gqview.sourceforge.io"
  url "https://downloads.sourceforge.net/project/gqview/gqview/2.0.4/gqview-2.0.4.tar.gz"
  sha256 "97e3b7ce5f17a315c56d6eefd7b3a60b40cc3d18858ca194c7e7262acce383cb"
  revision 2



  depends_on "pkg-config" => :build
  depends_on "gtk+"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    system "#{bin}/gqview", "--version"
  end
end
