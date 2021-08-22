class Fibjs < Formula
  desc "JavaScript on Fiber"
  homepage "http://fibjs.org/"
  url "https://github.com/fibjs/fibjs/releases/download/v0.26.1/fullsrc.zip"
  sha256 "36bf6add810959c9474a0f247473fe3b2a34f49cb7a3bcc4a5ac5d7fced17068"
  head "https://github.com/fibjs/fibjs.git"



  depends_on "cmake" => :build
  depends_on :macos => :sierra # fibjs requires >= Xcode 8.3 (or equivalent CLT)

  def install
    # the build script breaks when CI is set by Homebrew
    begin
      env_ci = ENV.delete "CI"
      system "./build", "release", "-j#{ENV.make_jobs}"
    ensure
      ENV["CI"] = env_ci
    end

    bin.install "bin/Darwin_amd64_release/fibjs"
  end

  test do
    path = testpath/"test.js"
    path.write "console.log('hello');"

    output = shell_output("#{bin}/fibjs #{path}").strip
    assert_equal "hello", output
  end
end
