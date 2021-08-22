class Cclive < Formula
  desc "Command-line video extraction utility"
  homepage "https://cclive.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/cclive/0.7/cclive-0.7.16.tar.xz"
  sha256 "586a120faddcfa16f5bb058b5c901f1659336c6fc85a0d3f1538882a44ee10e1"
  revision 3



  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "pcre"
  depends_on "quvi"

  conflicts_with "clozure-cl", :because => "both install a ccl binary"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    url = "https://youtu.be/VaVZL7F6vqU"
    output = shell_output("#{bin}/cclive --no-download #{url} 2>&1")
    assert_match "Martin Luther King Jr Day", output
  end
end
