class Abcl < Formula
  desc "Armed Bear Common Lisp: a full implementation of Common Lisp"
  homepage "https://abcl.org/"
  url "https://abcl.org/releases/1.5.0/abcl-src-1.5.0.tar.gz"
  sha256 "920ee7d634a7f4ceca0a469d431d3611a321c566814d5ddb92d75950c0631bc2"
  revision 1
  head "https://abcl.org/svn/trunk/abcl/", :using => :svn



  depends_on "ant"
  depends_on "java" => "1.8"
  depends_on "rlwrap"

  def install
    # cmd = Language::Java.java_home_cmd("1.8")
    # ENV["JAVA_HOME"] = Utils.popen_read(cmd).chomp
    ENV["JAVA_HOME"] = "/usr/local/Cellar/java/1.8/libexec/openjdk.jdk/Contents/Home/"

    system "ant"

    libexec.install "dist/abcl.jar", "dist/abcl-contrib.jar"
    (bin/"abcl").write <<~EOS
      #!/bin/sh
      export JAVA_HOME=$(#{cmd})
      rlwrap java -cp #{libexec}/abcl.jar:"$CLASSPATH" org.armedbear.lisp.Main "$@"
    EOS
  end

  test do
    (testpath/"test.lisp").write "(print \"Homebrew\")\n(quit)"
    assert_match /"Homebrew"$/, shell_output("#{bin}/abcl --load test.lisp").strip
  end
end
