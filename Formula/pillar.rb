class Pillar < Formula
  desc "Manage migrations for Cassandra data stores"
  homepage "https://github.com/comeara/pillar"
  url "https://github.com/comeara/pillar/archive/v2.3.0.tar.gz"
  sha256 "f1bb1f2913b10529263b5cf738dd171b14aff70e97a3c9f654c6fb49c91ef16f"



  depends_on "sbt" => :build
  depends_on "java" => "1.8"

  def install
    inreplace "src/main/bash/pillar" do |s|
      s.gsub! "$JAVA ", "`/usr/libexec/java_home --version 1.8`/bin/java "
      s.gsub! "${PILLAR_ROOT}/lib/pillar.jar", "#{libexec}/pillar-assembly-#{version}.jar"
      s.gsub! "${PILLAR_ROOT}/conf", "#{etc}/pillar-log4j.properties"
    end

    system "sbt", "assembly"

    bin.install "src/main/bash/pillar"
    etc.install "src/main/resources/pillar-log4j.properties"
    libexec.install "target/scala-2.10/pillar-assembly-#{version}.jar"
  end

  test do
    assert_match "Missing parameter", shell_output("#{bin}/pillar 2>&1", 1)
  end
end
