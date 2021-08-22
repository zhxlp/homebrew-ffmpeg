class Mogenerator < Formula
  desc "Generate Objective-C & Swift classes from your Core Data model"
  homepage "https://rentzsch.github.io/mogenerator/"
  url "https://github.com/rentzsch/mogenerator/archive/1.32.tar.gz"
  sha256 "4fa660a19934d94d7ef35626d68ada9912d925416395a6bf4497bd7df35d7a8b"
  head "https://github.com/rentzsch/mogenerator.git"



  depends_on :xcode => :build
  depends_on :macos => :yosemite

  def install
    xcodebuild "-target", "mogenerator", "-configuration", "Release", "SYMROOT=symroot", "OBJROOT=objroot"
    bin.install "symroot/Release/mogenerator"
  end

  test do
    system "#{bin}/mogenerator", "--version"
  end
end
