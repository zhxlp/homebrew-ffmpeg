class Codequery < Formula
  desc "Code-understanding, code-browsing or code-search tool"
  homepage "https://github.com/ruben2020/codequery"
  url "https://github.com/ruben2020/codequery/archive/v0.21.1.tar.gz"
  sha256 "c20050dc6963472c7cb7ed4621c7187e24089fa458eb68748ef9d2aae53d991f"



  depends_on "cmake" => :build
  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_QT5=ON"

    share.install "test"
    mkdir "build" do
      system "cmake", "..", "-G", "Unix Makefiles", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    # Copy test files as `cqmakedb` gets confused if we just symlink them.
    test_files = (share/"test").children
    cp test_files, testpath

    system "#{bin}/cqmakedb", "-s", "./codequery.db",
                              "-c", "./cscope.out",
                              "-t", "./tags",
                              "-p"
    output = shell_output("#{bin}/cqsearch -s ./codequery.db -t info_platform")
    assert_match "info_platform", output
  end
end
