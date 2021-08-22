class Nkf < Formula
  desc "Network Kanji code conversion Filter (NKF)"
  homepage "https://osdn.net/projects/nkf/"
  # Canonical: https://osdn.net/dl/nkf/nkf-2.1.4.tar.gz
  url "https://dotsrc.dl.osdn.net/osdn/nkf/64158/nkf-2.1.4.tar.gz"
  sha256 "b4175070825deb3e98577186502a8408c05921b0c8ff52e772219f9d2ece89cb"



  def install
    inreplace "Makefile", "$(prefix)/man", "$(prefix)/share/man"
    system "make", "CC=#{ENV.cc}"
    # Have to specify mkdir -p here since the intermediate directories
    # don't exist in an empty prefix
    system "make", "install", "prefix=#{prefix}", "MKDIR=mkdir -p"
  end

  test do
    system "#{bin}/nkf", "--version"
  end
end
