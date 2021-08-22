class Lumo < Formula
  desc "Fast, cross-platform, standalone ClojureScript environment"
  homepage "https://github.com/anmonteiro/lumo"
  url "https://github.com/anmonteiro/lumo/archive/1.9.0.tar.gz"
  sha256 "fc71a6a0b6ce928b3af93f1a119b6920d8bf6bbde1ed5f873f1bda4fb5fc23d7"
  head "https://github.com/anmonteiro/lumo.git"



  depends_on "boot-clj" => :build
  depends_on :java => ["1.8", :build]
  depends_on "node" => :build
  depends_on "yarn" => :build

  def install
    ENV["BOOT_HOME"] = "#{buildpath}/.boot"
    ENV["BOOT_LOCAL_REPO"] = "#{buildpath}/.m2/repository"
    system "boot", "release-ci"
    bin.install "build/lumo"
  end

  test do
    assert_equal "0", shell_output("#{bin}/lumo -e '(- 1 1)'").chomp
  end
end
