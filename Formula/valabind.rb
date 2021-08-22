class Valabind < Formula
  desc "Vala bindings for radare, reverse engineering framework"
  homepage "https://radare.org/"
  url "https://github.com/radare/valabind/archive/1.6.0.tar.gz"
  sha256 "0d266486655c257fd993758c3e4cc8e32f0ec6f45d0c0e15bb6e6be986e4b78e"
  revision 1
  head "https://github.com/radare/valabind.git"



  depends_on "pkg-config" => :build
  depends_on "swig"
  depends_on "vala"

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system bin/"valabind", "--help"
  end
end
