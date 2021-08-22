class Cquery < Formula
  desc "C/C++ language server"
  homepage "https://github.com/cquery-project/cquery"
  # pull from git tag to get submodules
  url "https://github.com/cquery-project/cquery.git",
      :tag      => "v20180718",
      :revision => "b523aa928acf8ffb3de6b22c79db7366a9672489"
  head "https://github.com/cquery-project/cquery.git"



  depends_on "cmake" => :build
  depends_on "llvm"

  # error: 'shared_timed_mutex' is unavailable: introduced in macOS 10.12
  depends_on :macos => :sierra

  def install
    system "cmake", ".", "-DSYSTEM_CLANG=ON", *std_cmake_args
    system "make", "install"
  end

  test do
    system bin/"cquery", "--test-unit"
  end
end
