class Pulledpork < Formula
  desc "Snort rule management"
  homepage "https://github.com/shirkdog/pulledpork"
  url "https://github.com/shirkdog/pulledpork/archive/v0.7.3.tar.gz"
  sha256 "48c66dc9abb7545186d4fba497263c1d1b247c0ea7f0953db4d515e7898461a2"
  head "https://github.com/shirkdog/pulledpork.git"



  depends_on "openssl"

  resource "Switch" do
    url "https://cpan.metacpan.org/authors/id/C/CH/CHORNY/Switch-2.17.tar.gz"
    sha256 "31354975140fe6235ac130a109496491ad33dd42f9c62189e23f49f75f936d75"
  end

  resource "Crypt::SSLeay" do
    url "https://cpan.metacpan.org/authors/id/N/NA/NANIS/Crypt-SSLeay-0.72.tar.gz"
    sha256 "f5d34f813677829857cf8a0458623db45b4d9c2311daaebe446f9e01afa9ffe8"
  end

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    resources.each do |r|
      r.stage do
        system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
        system "make"
        system "make", "install"
      end
    end

    chmod 0755, "pulledpork.pl"
    bin.install "pulledpork.pl"
    bin.env_script_all_files(libexec/"bin", :PERL5LIB => ENV["PERL5LIB"])
    doc.install Dir["doc/*"]
    (etc/"pulledpork").install Dir["etc/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pulledpork.pl -V")
  end
end
