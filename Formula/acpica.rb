class Acpica < Formula
  desc "OS-independent implementation of the ACPI specification"
  homepage "https://www.acpica.org/"
  url "https://acpica.org/sites/acpica/files/acpica-unix-20180810.tar.gz"
  sha256 "2643911d0e74c52e4122b914dbbbfa8e2559e4414342bc45f268d2fae32c1ef3"
  head "https://github.com/acpica/acpica.git"



  def install
    ENV.deparallelize
    system "make", "PREFIX=#{prefix}"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/acpihelp", "-u"
  end
end
