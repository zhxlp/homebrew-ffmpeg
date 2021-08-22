class S3Backer < Formula
  desc "FUSE-based single file backing store via Amazon S3"
  homepage "https://github.com/archiecobbs/s3backer"
  url "https://s3.amazonaws.com/archie-public/s3backer/s3backer-1.5.0.tar.gz"
  sha256 "82d93c54acb1e85828b6b80a06e69a99c7e06bf6ee025dac720e980590d220d2"



  depends_on "pkg-config" => :build
  depends_on "openssl"
  depends_on :osxfuse

  def install
    inreplace "configure", "-lfuse", "-losxfuse"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"s3backer", "--version"
  end
end
