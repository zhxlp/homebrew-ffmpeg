class Voms < Formula
  desc "Virtual organization membership service"
  homepage "https://github.com/italiangrid/voms"
  url "https://github.com/italiangrid/voms-clients/archive/v3.0.7.tar.gz"
  sha256 "24cc29f4dc93f048e1cda9003ab8004e5d0ebc245d0139a058e6224bc2ca6ba7"



  depends_on "maven" => :build
  depends_on :java
  depends_on "openssl"

  def install
    system "mvn", "package", "-Dmaven.repo.local=$(pwd)/m2repo/", "-Dmaven.javadoc.skip=true"
    system "tar", "-xf", "target/voms-clients.tar.gz"
    share.install "voms-clients/share/java"
    man5.install Dir["voms-clients/share/man/man5/*.5"]
    man1.install Dir["voms-clients/share/man/man1/*.1"]
    bin.install Dir["voms-clients/bin/*"]
  end

  test do
    system "#{bin}/voms-proxy-info", "--version"
  end
end
