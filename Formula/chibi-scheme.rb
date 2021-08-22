class ChibiScheme < Formula
  desc "Small footprint Scheme for use as a C Extension Language"
  homepage "http://synthcode.com/wiki/chibi-scheme"
  url "http://synthcode.com/scheme/chibi/chibi-scheme-0.8.0.tgz"
  sha256 "c39287628cb7762d6cd51fbdab39e797ef7f7e576a3c7650a8a2a02b4f35749a"
  head "https://github.com/ashinn/chibi-scheme.git"



  def install
    ENV.deparallelize

    # "make" and "make install" must be done separately
    system "make", "PREFIX=#{prefix}"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    output = `#{bin}/chibi-scheme -mchibi -e "(for-each write '(0 1 2 3 4 5 6 7 8 9))"`
    assert_equal "0123456789", output
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
