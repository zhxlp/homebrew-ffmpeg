class Gssh < Formula
  desc "SSH automation tool based on Groovy DSL"
  homepage "https://github.com/int128/groovy-ssh"
  url "https://github.com/int128/groovy-ssh/archive/2.9.0.tar.gz"
  sha256 "9199c675b91041858a246eee156c6ed0d65d153efafb62820f66d3722b9d17bf"
  revision 1



  depends_on "java" => "1.8"

  def install
    ENV["CIRCLE_TAG"] = version
    system "./gradlew", "shadowJar"
    libexec.install "cli/build/libs/gssh.jar"
    bin.write_jar_script libexec/"gssh.jar", "gssh", :java_version => "1.8"
  end

  test do
    system bin/"gssh"
  end
end
