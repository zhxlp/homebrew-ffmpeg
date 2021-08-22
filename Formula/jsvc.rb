class Jsvc < Formula
  desc "Wrapper to launch Java applications as daemons"
  homepage "https://commons.apache.org/daemon/jsvc.html"
  url "https://www.apache.org/dyn/closer.cgi?path=commons/daemon/source/commons-daemon-1.1.0-native-src.tar.gz"
  sha256 "11962bc602619fd2eeb840f74a8c63cc1055221f0cc385a1fa906e758d39888d"



  depends_on "java"

  def install
    ENV.append "CFLAGS", "-arch #{MacOS.preferred_arch}"
    ENV.append "LDFLAGS", "-arch #{MacOS.preferred_arch}"
    ENV.append "CPPFLAGS", "-I/System/Library/Frameworks/JavaVM.framework/Versions/Current/Headers"

    prefix.install %w[NOTICE.txt LICENSE.txt RELEASE-NOTES.txt]

    cd "unix"
    system "./configure", "--with-java=/System/Library/Frameworks/JavaVM.framework",
                          "--with-os-type=Headers"
    system "make"
    bin.install "jsvc"
  end
end
