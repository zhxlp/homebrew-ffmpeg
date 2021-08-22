class Hqx < Formula
  desc "Magnification filter designed for pixel art"
  homepage "https://code.google.com/archive/p/hqx/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/hqx/hqx-1.1.tar.gz"
  sha256 "cc18f571fb4bc325317892e39ecd5711c4901831926bc93296de9ebb7b2f317b"
  revision 2



  depends_on "devil"

  def install
    ENV.deparallelize
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"hqx", test_fixtures("test.jpg"), "out.jpg"
    output = pipe_output("php -r \"print_r(getimagesize(\'file://#{testpath}/out.jpg\'));\"")
    assert_equal <<~EOS, output
      Array
      (
          [0] => 4
          [1] => 4
          [2] => 2
          [3] => width="4" height="4"
          [bits] => 8
          [channels] => 3
          [mime] => image/jpeg
      )
    EOS
  end
end
