class ScalaAT211 < Formula
  desc "JVM-based programming language"
  homepage "https://www.scala-lang.org/"
  url "https://downloads.lightbend.com/scala/2.11.12/scala-2.11.12.tgz"
  mirror "https://downloads.typesafe.com/scala/2.11.12/scala-2.11.12.tgz"
  mirror "https://www.scala-lang.org/files/archive/scala-2.11.12.tgz"
  sha256 "b11d7d33699ca4f60bc3b2b6858fd953e3de2b8522c943f4cda4b674316196a8"

  bottle :unneeded

  keg_only :versioned_formula

  depends_on "java" => "1.8"

  def install
    rm_f Dir["bin/*.bat"]
    doc.install Dir["doc/*"]
    share.install "man"
    libexec.install "bin", "lib"
    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", Language::Java.java_home_env("1.8"))

    # Set up an IntelliJ compatible symlink farm in 'idea'
    idea = prefix/"idea"
    idea.install_symlink libexec/"src", libexec/"lib"
    idea.install_symlink doc => "doc"
  end

  test do
    file = testpath/"Test.scala"
    file.write <<~EOS
      object Test {
        def main(args: Array[String]) {
          println(s"${2 + 2}")
        }
      }
    EOS

    out = shell_output("#{bin}/scala #{file}").strip
    # Shut down the compile server so as not to break Travis
    system bin/"fsc", "-shutdown"

    assert_equal "4", out
  end
end
