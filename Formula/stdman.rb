class Stdman < Formula
  desc "Formatted C++11/14/17 stdlib man pages from cppreference.com"
  homepage "https://github.com/jeaye/stdman"
  url "https://github.com/jeaye/stdman/archive/2018.03.11.tar.gz"
  sha256 "d29e6b34cb5ba9905360cee6adcdf8c49e7f11272521bf2e10b42917486840e8"
  version_scheme 1
  head "https://github.com/jeaye/stdman.git"



  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "man", "-w", "std::string"
  end
end
