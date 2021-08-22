class Multimarkdown < Formula
  desc "Turn marked-up plain text into well-formatted documents"
  homepage "https://fletcher.github.io/MultiMarkdown-6/"
  url "https://github.com/fletcher/MultiMarkdown-6/archive/6.4.0.tar.gz"
  sha256 "fa9daa089bc0f8bc1f69fd7365778d59210b446ce7008d03b87fb572df8ff5d3"
  head "https://github.com/fletcher/MultiMarkdown-6.git"



  depends_on "cmake" => :build

  conflicts_with "mtools", :because => "both install `mmd` binaries"
  conflicts_with "markdown", :because => "both install `markdown` binaries"
  conflicts_with "discount", :because => "both install `markdown` binaries"

  def install
    # Reported upstream 2 Sep 2018 https://github.com/fletcher/MultiMarkdown-6/issues/142
    inreplace "CMakeLists.txt",
              "SET(CMAKE_OSX_DEPLOYMENT_TARGET \"10.4\"",
              "SET(CMAKE_OSX_DEPLOYMENT_TARGET \"#{MacOS.version}\""

    system "make", "release"

    cd "build" do
      system "make"
      bin.install "multimarkdown"
    end

    bin.install Dir["scripts/*"].reject { |f| f =~ /\.bat$/ }
  end

  test do
    assert_equal "<p>foo <em>bar</em></p>\n", pipe_output(bin/"multimarkdown", "foo *bar*\n")
    assert_equal "<p>foo <em>bar</em></p>\n", pipe_output(bin/"mmd", "foo *bar*\n")
  end
end
