class TmuxMemCpuLoad < Formula
  desc "CPU, RAM memory, and load monitor for use with tmux"
  homepage "https://github.com/thewtex/tmux-mem-cpu-load"
  url "https://github.com/thewtex/tmux-mem-cpu-load/archive/v3.4.0.tar.gz"
  sha256 "a773994e160812a964abc7fc4e8ec16b7d9833edb0a66e5c67f287c7c5949ecb"
  head "https://github.com/thewtex/tmux-mem-cpu-load.git"



  depends_on "cmake" => :build

  def install
    ENV.cxx11
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system bin/"tmux-mem-cpu-load"
  end
end
