class Hexgui < Formula
  desc "GUI for playing Hex over Hex Text Protocol"
  homepage "https://sourceforge.net/p/benzene/hexgui/"
  url "https://github.com/apetresc/hexgui/archive/v0.9.2.tar.gz"
  sha256 "8c4c808b72412e4f3d506921f21692ec63ed28a783179fbdee4eb19ed82fdeb8"
  head "https://github.com/apetresc/hexgui.git"



  depends_on "ant" => :build
  depends_on :java => "1.8"

  def install
    system "ant"
    libexec.install Dir["*"]
    (bin/"hexgui").write_env_script libexec/"bin/hexgui", Language::Java.java_home_env("1.8")
  end

  test do
    assert_match /^HexGui #{version} .*/, shell_output("#{bin}/hexgui -version").chomp
  end
end
