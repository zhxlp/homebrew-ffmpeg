class ChromeCli < Formula
  desc "Control Google Chrome from the command-line"
  homepage "https://github.com/prasmussen/chrome-cli"
  url "https://github.com/prasmussen/chrome-cli/archive/1.6.0.tar.gz"
  sha256 "ff1fba560743cba7b661e8daef52d4494acc084da4a21c3fad211f7cdf5e971f"
  head "https://github.com/prasmussen/chrome-cli.git"



  depends_on :xcode => :build

  def install
    # Release builds
    xcodebuild "SDKROOT=", "SYMROOT=build"
    bin.install "build/Release/chrome-cli"

    # Canary builds; see:
    # https://github.com/prasmussen/chrome-cli/issues/15
    rm_rf "build"
    inreplace "chrome-cli/App.m", "com.google.Chrome", "com.google.Chrome.canary"
    xcodebuild "SDKROOT=", "SYMROOT=build"
    bin.install "build/Release/chrome-cli" => "chrome-canary-cli"

    # Chromium builds; see:
    # https://github.com/prasmussen/chrome-cli/issues/31
    rm_rf "build"
    inreplace "chrome-cli/App.m", "com.google.Chrome.canary", "org.Chromium.chromium"
    xcodebuild "SDKROOT=", "SYMROOT=build"
    bin.install "build/Release/chrome-cli" => "chromium-cli"
  end

  test do
    system "#{bin}/chrome-cli", "version"
  end
end
