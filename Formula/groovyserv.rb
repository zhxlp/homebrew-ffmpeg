class Groovyserv < Formula
  desc "Speed up Groovy startup time"
  homepage "https://kobo.github.io/groovyserv/"
  url "https://bitbucket.org/kobo/groovyserv-mirror/downloads/groovyserv-1.2.0-src.zip"
  sha256 "235b38c6bb70721fa41b2c2cc6224eeaac09721e4d04b504148b83c40ea0bb27"



  depends_on "go" => :build
  depends_on "groovy"
  depends_on :java => "1.8"

  def install
    # Sandbox fix to stop it ignoring our temporary $HOME variable.
    ENV["GRADLE_USER_HOME"] = buildpath/".brew_home"
    system "./gradlew", "clean", "distLocalBin"
    system "unzip", "build/distributions/groovyserv-#{version}-bin-local.zip"
    libexec.install Dir["groovyserv-#{version}/{bin,lib}"]
    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", Language::Java.java_home_env("1.8"))
  end

  test do
    system bin/"groovyserver", "--help"
  end
end
