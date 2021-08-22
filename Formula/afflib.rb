class Afflib < Formula
  desc "Advanced Forensic Format"
  homepage "https://github.com/sshock/AFFLIBv3"
  url "https://github.com/sshock/AFFLIBv3/archive/v3.7.17.tar.gz"
  sha256 "3c5a718731c90a75a1134796ab9de9a0156f6b3a8d1dec4f532e161b94bdaff4"
  revision 1



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "openssl"
  # Python 3 error filed upstream: https://github.com/sshock/AFFLIBv3/issues/35
  depends_on "python@2" # does not support Python 3

  def install
    args = %w[
      --enable-s3
      --enable-python
      --disable-fuse
    ]

    system "autoreconf", "-fiv"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          *args
    system "make", "install"
  end

  test do
    system "#{bin}/affcat", "-v"
  end
end
