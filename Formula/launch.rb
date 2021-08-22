class Launch < Formula
  desc "Command-line launcher for macOS, in the spirit of `open`"
  homepage "https://sabi.net/nriley/software/#launch"
  url "https://sabi.net/nriley/software/launch-1.2.5.tar.gz"
  sha256 "486632b11bee04d9f6bcb595fd2a68b5fde2f748ebdc182274778cc5cf97ff70"
  head "https://github.com/nriley/launch.git"



  depends_on :xcode => :build

  def install
    rm_rf "launch" # We'll build it ourself, thanks.
    xcodebuild "-configuration", "Deployment", "SYMROOT=build", "clean"
    xcodebuild "-configuration", "Deployment", "SYMROOT=build"

    man1.install gzip("launch.1")
    bin.install "build/Deployment/launch"
  end

  test do
    assert_equal "/", shell_output("#{bin}/launch -n /").chomp
  end
end
