class Le < Formula
  desc "Text editor with block and binary operations"
  homepage "https://github.com/lavv17/le"
  url "https://github.com/lavv17/le/releases/download/v1.16.5/le-1.16.5.tar.xz"
  sha256 "258d586f83e8abd55144dc3f09d9ddaf6ef55e8a90543fdb0932fb77d089dd78"



  conflicts_with "logentries", :because => "both install a le binary"

  def install
    ENV.deparallelize
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/le --help", 1)
  end
end
