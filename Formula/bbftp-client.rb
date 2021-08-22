class BbftpClient < Formula
  desc "Secure file transfer software, optimized for large files"
  homepage "https://software.in2p3.fr/bbftp/"
  url "https://software.in2p3.fr/bbftp/dist/bbftp-client-3.2.1.tar.gz"
  mirror "https://dl.bintray.com/homebrew/mirror/bbftp-client-3.2.1.tar.gz"
  sha256 "4000009804d90926ad3c0e770099874084fb49013e8b0770b82678462304456d"
  revision 1



  depends_on "openssl"

  def install
    # Fix ntohll errors; reported 14 Jan 2015.
    ENV.append_to_cflags "-DHAVE_NTOHLL" if MacOS.version >= :yosemite

    cd "bbftpc" do
      system "./configure", "--disable-debug", "--disable-dependency-tracking",
                            "--with-ssl=#{Formula["openssl"].opt_prefix}", "--prefix=#{prefix}"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/bbftp", "-v"
  end
end
