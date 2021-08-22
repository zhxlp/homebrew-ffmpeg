class Editorconfig < Formula
  desc "Maintain consistent coding style between multiple editors"
  homepage "https://editorconfig.org/"
  url "https://github.com/editorconfig/editorconfig-core-c/archive/v0.12.3.tar.gz"
  sha256 "64edf79500e104e47035cace903f5c299edba778dcff71b814b7095a9f14cbc1"
  head "https://github.com/editorconfig/editorconfig-core-c.git"



  depends_on "cmake" => :build
  depends_on "pcre2"

  def install
    system "cmake", ".", "-DCMAKE_INSTALL_PREFIX:PATH=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/editorconfig", "--version"
  end
end
