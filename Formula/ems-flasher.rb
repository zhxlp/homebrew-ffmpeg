class EmsFlasher < Formula
  desc "Software for flashing the EMS Gameboy USB cart"
  homepage "https://lacklustre.net/projects/ems-flasher/"
  url "https://lacklustre.net/projects/ems-flasher/ems-flasher-0.03.tgz"
  sha256 "d77723a3956e00a9b8af9a3545ed2c55cd2653d65137e91b38523f7805316786"



  head do
    url "https://github.com/mikeryan/ems-flasher.git"
    depends_on "coreutils" => :build
    depends_on "gawk" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "libusb"

  def install
    if build.head?
      system "./config.sh", "--prefix", prefix
      man1.mkpath
      system "make", "install"
    else
      system "make"
      bin.install "ems-flasher"
    end
  end

  test do
    system "#{bin}/ems-flasher", "--version"
  end
end
