class FuseZip < Formula
  desc "FUSE file system to create & manipulate ZIP archives"
  homepage "https://bitbucket.org/agalanin/fuse-zip"
  url "https://bitbucket.org/agalanin/fuse-zip/downloads/fuse-zip-0.4.5.tar.gz"
  sha256 "2c5101f5bcb8d666d1ca602717ba901567dad2e7ad7de9db6e5bb26ac57435d1"
  head "https://bitbucket.org/agalanin/fuse-zip", :using => :hg



  depends_on "pkg-config" => :build
  depends_on "libzip"
  depends_on :osxfuse

  def install
    system "make", "prefix=#{prefix}", "install"
  end

  test do
    system bin/"fuse-zip", "--help"
  end
end
