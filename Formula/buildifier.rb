class Buildifier < Formula
  desc "Format bazel BUILD files with a standard convention"
  homepage "https://github.com/bazelbuild/buildtools"
  url "https://github.com/bazelbuild/buildtools.git",
      :tag      => "0.20.0",
      :revision => "db073457c5a56d810e46efc18bb93a4fd7aa7b5e"



  depends_on "bazel" => :build

  def install
    system "bazel", "build", "--workspace_status_command=#{buildpath}/status.sh", "buildifier:buildifier"
    bin.install "bazel-bin/buildifier/darwin_amd64_stripped/buildifier"
  end

  test do
    touch testpath/"BUILD"
    system "#{bin}/buildifier", "-mode=check", "BUILD"
  end
end
