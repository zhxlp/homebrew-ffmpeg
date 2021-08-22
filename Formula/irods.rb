class Irods < Formula
  desc "Integrated data grid software solution"
  homepage "https://irods.org/"
  url "https://github.com/irods/irods-legacy/archive/3.3.1.tar.gz"
  sha256 "e34e7be8646317d5be1c84e680d8f59d50a223ea25a3c9717b6bf7b57df5b9f6"
  revision 1



  depends_on "openssl"

  conflicts_with "sleuthkit", :because => "both install `ils`"
  conflicts_with "renameutils",
    :because => "both install `icp` and `imv` binaries"

  def install
    cd "iRODS" do
      system "./scripts/configure"

      # include PAM authentication by default
      inreplace "config/config.mk", "# PAM_AUTH = 1", "PAM_AUTH = 1"
      inreplace "config/config.mk", "# USE_SSL = 1", "USE_SSL = 1"

      system "make"
      bin.install Dir["clients/icommands/bin/*"].select { |f| File.executable? f }
    end
  end

  test do
    system "#{bin}/ipwd"
  end
end
