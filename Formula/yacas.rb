class Yacas < Formula
  desc "General purpose computer algebra system"
  homepage "https://www.yacas.org/"
  url "https://github.com/grzegorzmazur/yacas/archive/v1.6.1.tar.gz"
  sha256 "6b94394f705bed70a9d104967073efd6c23e9eb1a832805c4d805ef875555ae5"



  depends_on "cmake" => :build
  depends_on :xcode => :build

  def install
    mkdir "build" do
      system "cmake", "..", "-G", "Xcode", "-DENABLE_CYACAS_GUI=OFF",
                            "-DENABLE_CYACAS_KERNEL=OFF", *std_cmake_args
      xcodebuild "-target", "ALL_BUILD", "-project", "YACAS.xcodeproj",
                 "-configuration", "Release", "SYMROOT=build/cyacas/libyacas"
    end
    bin.install "build/cyacas/libyacas/Release/yacas"
    lib.install Dir["build/cyacas/libyacas/Release/{libyacas.a,yacas.framework}"]
    pkgshare.install "scripts"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/yacas -v")
  end
end
