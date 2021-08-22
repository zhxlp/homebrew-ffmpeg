class Pelikan < Formula
  desc "Production-ready cache services"
  homepage "https://twitter.github.io/pelikan"
  url "https://github.com/twitter/pelikan/archive/0.1.2.tar.gz"
  sha256 "c105fdab8306f10c1dfa660b4e958ff6f381a5099eabcb15013ba42e4635f824"
  head "https://github.com/twitter/pelikan.git"



  depends_on "cmake" => :build

  def install
    mkdir "_build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/pelikan_twemcache", "-c"
  end
end
