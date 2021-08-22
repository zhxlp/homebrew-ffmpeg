class Gammu < Formula
  desc "Command-line utility to control a phone"
  homepage "https://wammu.eu/gammu/"
  url "https://dl.cihar.com/gammu/releases/gammu-1.39.0.tar.xz"
  sha256 "66d1d991d7a993fdf254d4c425f0fdd38c9cca15b1735936695a486067a6a9f8"
  head "https://github.com/gammu/gammu.git"



  depends_on "cmake" => :build
  depends_on "glib"
  depends_on "openssl"

  def install
    mkdir "build" do
      system "cmake", "..", "-DBASH_COMPLETION_COMPLETIONSDIR:PATH=#{bash_completion}", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    system bin/"gammu", "--help"
  end
end
