class Libpuzzle < Formula
  desc "Library to find visually similar images"
  homepage "https://www.pureftpd.org/project/libpuzzle"
  url "https://download.pureftpd.org/pub/pure-ftpd/misc/libpuzzle/releases/libpuzzle-0.11.tar.bz2"
  sha256 "ba628268df6956366cbd44ae48c3f1bab41e70b4737041a1f33dac9832c44781"



  depends_on "gd"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    test_image = test_fixtures("test.jpg")
    assert_equal "0",
      shell_output("#{bin}/puzzle-diff #{test_image} #{test_image}").chomp
  end
end
