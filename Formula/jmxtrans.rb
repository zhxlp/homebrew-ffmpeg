class Jmxtrans < Formula
  desc "Tool to connect to JVMs and query their attributes"
  homepage "https://github.com/jmxtrans/jmxtrans"
  url "https://github.com/jmxtrans/jmxtrans/archive/jmxtrans-parent-270.tar.gz"
  sha256 "7261eb083e0ad927d69bc48bd190a0c1c1a340f20812514bd0ee59e4b25f8fd0"
  version_scheme 1



  depends_on "maven" => :build
  depends_on "java" => "1.8"

  def install
    # cmd = Language::Java.java_home_cmd("1.8")
    # ENV["JAVA_HOME"] = Utils.popen_read(cmd).chomp
    ENV["JAVA_HOME"] = "/usr/local/Cellar/java/1.8/libexec/openjdk.jdk/Contents/Home/"

    system "mvn", "package", "-DskipTests=true",
                             "-Dmaven.javadoc.skip=true",
                             "-Dcobertura.skip=true"

    cd "jmxtrans" do
      vers = Formula["jmxtrans"].version.to_s.split("-").last
      inreplace "jmxtrans.sh", "lib/jmxtrans-all.jar",
                               libexec/"target/jmxtrans-#{vers}-all.jar"
      chmod 0755, "jmxtrans.sh"
      libexec.install %w[jmxtrans.sh target]
      pkgshare.install %w[bin example.json src tools vagrant]
      doc.install Dir["doc/*"]
    end

    (bin/"jmxtrans").write_env_script libexec/"jmxtrans.sh", Language::Java.java_home_env("1.8")
  end

  test do
    output = shell_output("#{bin}/jmxtrans status", 3).chomp
    assert_equal "jmxtrans is not running.", output
  end
end
