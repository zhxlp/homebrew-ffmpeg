class Voldemort < Formula
  desc "Distributed key-value storage system"
  homepage "https://www.project-voldemort.com/"
  url "https://github.com/voldemort/voldemort/archive/release-1.10.26-cutoff.tar.gz"
  sha256 "8bd41b53c3b903615d281e7277d5a9225075c3d00ea56c6e44d73f6327c73d55"



  depends_on "gradle" => :build
  depends_on "java" => "1.8"

  def install
    system "./gradlew", "build", "-x", "test"
    libexec.install %w[lib dist contrib]
    bin.install Dir["bin/*{.sh,.py}"]
    libexec.install "bin"
    pkgshare.install "config" => "config-examples"
    (etc/"voldemort").mkpath
    env = {
      :VOLDEMORT_HOME       => libexec,
      :VOLDEMORT_CONFIG_DIR => etc/"voldemort",
    }
    bin.env_script_all_files(libexec/"bin", env)
  end

  test do
    system bin/"vadmin.sh"
  end
end
