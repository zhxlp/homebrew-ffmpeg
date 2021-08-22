class Htmlcxx < Formula
  desc "Non-validating CSS1 and HTML parser for C++"
  homepage "https://htmlcxx.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/htmlcxx/htmlcxx/0.86/htmlcxx-0.86.tar.gz"
  sha256 "07542b5ea2442143b125ba213b6823ff4a23fff352ecdd84bbebe1d154f4f5c1"



  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/htmlcxx -V 2>&1").chomp
  end
end
