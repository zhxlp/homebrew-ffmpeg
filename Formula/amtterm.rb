class Amtterm < Formula
  desc "Serial-over-LAN (sol) client for Intel AMT"
  homepage "https://www.kraxel.org/blog/linux/amtterm/"
  url "https://www.kraxel.org/releases/amtterm/amtterm-1.6.tar.gz"
  sha256 "1242cea467827aa1e2e91b41846229ca0a5b3f3e09260b0df9d78dc875075590"
  head "https://www.kraxel.org/cgit/amtterm", :using => :git



  resource "SOAP::Lite" do
    url "https://cpan.metacpan.org/authors/id/P/PH/PHRED/SOAP-Lite-1.11.tar.gz"
    sha256 "e4dee589ef7d66314b3dc956569b2541e0b917e834974e078c256571b6011efe"
  end

  def install
    ENV.prepend_create_path "PERL5LIB", libexec+"lib/perl5"

    resource("SOAP::Lite").stage do
      system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
      system "make"
      system "make", "install"
    end

    system "make", "prefix=#{prefix}", "install"
    bin.env_script_all_files(libexec+"bin", :PERL5LIB => ENV["PERL5LIB"])
  end

  test do
    system "#{bin}/amtterm", "-h"
  end
end
