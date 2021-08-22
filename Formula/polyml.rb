class Polyml < Formula
  desc "Standard ML implementation"
  homepage "https://www.polyml.org/"
  url "https://github.com/polyml/polyml/archive/v5.7.1.tar.gz"
  sha256 "d18dd824b426edaed1cec71dded354b57df9ebdbd38863bc7540a60bd0667028"
  head "https://github.com/polyml/polyml.git"



  def install
    system "./configure", "--disable-dependency-tracking", "--disable-debug",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
