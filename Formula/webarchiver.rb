class Webarchiver < Formula
  desc "Allows you to create Safari .webarchive files"
  homepage "https://github.com/newzealandpaul/webarchiver"
  url "https://github.com/newzealandpaul/webarchiver/archive/0.9.tar.gz"
  sha256 "8ea826038e923c72e75a4bbb1416910368140a675421f6aaa51fd0dea703f75c"
  head "https://github.com/newzealandpaul/webarchiver.git"



  depends_on :xcode => ["6.0.1", :build]

  def install
    # Force 64 bit-only build, otherwise it fails on Mojave
    xcodebuild "SYMROOT=build", "-arch", "x86_64"

    bin.install "./build/Release/webarchiver"
  end

  test do
    system "#{bin}/webarchiver", "-url", "https://www.google.com", "-output", "foo.webarchive"
    assert_match /Apple binary property list/, shell_output("file foo.webarchive")
  end
end
