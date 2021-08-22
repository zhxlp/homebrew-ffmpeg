class Glslviewer < Formula
  desc "Live-coding console tool that renders GLSL Shaders"
  homepage "http://patriciogonzalezvivo.com/2015/glslViewer/"
  url "https://github.com/patriciogonzalezvivo/glslViewer/archive/1.5.5.tar.gz"
  sha256 "28a784d701294fd335031ab293c5f4764a498f84714b1ae677dbc4e05ed94b23"
  head "https://github.com/patriciogonzalezvivo/glslViewer.git"



  depends_on "pkg-config" => :build
  depends_on "glfw"

  def install
    system "make"
    bin.install Dir["bin/*"]
  end

  test do
    system "#{bin}/glslViewer", "--help"
  end
end
