class Exif < Formula
  desc "Read, write, modify, and display EXIF data on the command-line"
  homepage "https://libexif.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/libexif/exif/0.6.21/exif-0.6.21.tar.gz"
  sha256 "1e2e40e5d919edfb23717308eb5aeb5a11337741e6455c049852128a42288e6d"



  depends_on "pkg-config" => :build
  depends_on "libexif"
  depends_on "popt"

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-silent-rules
      --disable-nls
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    test_image = test_fixtures("test.jpg")
    assert_match "The data supplied does not seem to contain EXIF data.",
                 shell_output("#{bin}/exif #{test_image} 2>&1", 1)
  end
end
