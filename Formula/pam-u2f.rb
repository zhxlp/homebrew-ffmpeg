class PamU2f < Formula
  desc "Provides an easy way to use U2F-compliant authenticators with PAM"
  homepage "https://developers.yubico.com/pam-u2f/"
  url "https://developers.yubico.com/pam-u2f/Releases/pam_u2f-1.0.7.tar.gz"
  sha256 "034aad8e29b159443dd6c1b7740006addc83d0659304fc4b0b4fb592f768e7cf"
  head "https://github.com/Yubico/pam-u2f.git"



  depends_on "asciidoc" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "libu2f-host"
  depends_on "libu2f-server"

  def install
    system "autoreconf", "--install"

    ENV["A2X"] = "#{Formula["asciidoc"].opt_bin}/a2x --no-xmllint"
    system "./configure", "--prefix=#{prefix}", "--with-pam-dir=#{lib}/pam"
    system "make", "install"
  end

  def caveats; <<~EOS
    To use a U2F key for PAM authentication, specify the full path to the
    module (#{opt_lib}/pam/pam_u2f.so) in a PAM
    configuration. You can find all PAM configurations in /etc/pam.d.

    For further installation instructions, please visit
    https://developers.yubico.com/pam-u2f/#installation.
  EOS
  end

  test do
    system "#{bin}/pamu2fcfg", "--version"
  end
end
