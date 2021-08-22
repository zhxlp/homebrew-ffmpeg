class Bear < Formula
  desc "Generate compilation database for clang tooling"
  homepage "https://github.com/rizsotto/Bear"
  url "https://github.com/rizsotto/Bear/archive/2.3.13.tar.gz"
  sha256 "dc14c28bfbe0beef5ec93b4614a00bd419d5a793c8a678ba3b5544bd1dd580b6"
  revision 1
  head "https://github.com/rizsotto/Bear.git"



  depends_on "cmake" => :build
  depends_on "python"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/bear", "true"
    assert_predicate testpath/"compile_commands.json", :exist?
  end
end
