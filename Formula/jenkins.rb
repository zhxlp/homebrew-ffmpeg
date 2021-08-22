class Jenkins < Formula
  desc "Extendable open source continuous integration server"
  homepage "https://jenkins.io/"
  url "http://mirrors.jenkins.io/war/2.163/jenkins.war"
  sha256 "fdf78f2348d88e6abd7807a3d61c02f2c2faa6b917a2a6018eaf498afd4a9454"

  head do
    url "https://github.com/jenkinsci/jenkins.git"
    depends_on "maven" => :build
  end

  bottle :unneeded

  depends_on :java => "1.8"

  def install
    if build.head?
      system "mvn", "clean", "install", "-pl", "war", "-am", "-DskipTests"
    else
      system "jar", "xvf", "jenkins.war"
    end
    libexec.install Dir["**/jenkins.war", "**/jenkins-cli.jar"]
    bin.write_jar_script libexec/"jenkins.war", "jenkins", :java_version => "1.8"
    bin.write_jar_script libexec/"jenkins-cli.jar", "jenkins-cli", :java_version => "1.8"
  end

  def caveats; <<~EOS
    Note: When using launchctl the port will be 8080.
  EOS
  end

  plist_options :manual => "jenkins"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>/usr/libexec/java_home</string>
          <string>-v</string>
          <string>1.8</string>
          <string>--exec</string>
          <string>java</string>
          <string>-Dmail.smtp.starttls.enable=true</string>
          <string>-jar</string>
          <string>#{opt_libexec}/jenkins.war</string>
          <string>--httpListenAddress=127.0.0.1</string>
          <string>--httpPort=8080</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
      </dict>
    </plist>
  EOS
  end

  test do
    ENV["JENKINS_HOME"] = testpath
    ENV.prepend "_JAVA_OPTIONS", "-Djava.io.tmpdir=#{testpath}"
    pid = fork do
      exec "#{bin}/jenkins"
    end
    sleep 60

    begin
      assert_match /Welcome to Jenkins!|Unlock Jenkins|Authentication required/, shell_output("curl localhost:8080/")
    ensure
      Process.kill("SIGINT", pid)
      Process.wait(pid)
    end
  end
end
