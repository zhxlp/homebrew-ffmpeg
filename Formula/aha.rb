class Aha < Formula
  desc "ANSI HTML adapter"
  homepage "https://github.com/theZiz/aha"
  url "https://github.com/theZiz/aha/archive/0.5.tar.gz"
  sha256 "6f8b044bee9760a1a85dffbc362e532d7dd91bb20b7ed4f241ff1119ad74758f"
  head "https://github.com/theZiz/aha.git"



  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    out = pipe_output(bin/"aha", "[35mrain[34mpill[00m")
    assert_match(/color:purple;">rain.*color:blue;">pill/, out)
  end
end
