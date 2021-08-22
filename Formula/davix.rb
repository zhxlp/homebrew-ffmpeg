class Davix < Formula
  desc "Library and tools for advanced file I/O with HTTP-based protocols"
  homepage "https://dmc.web.cern.ch/projects/davix/home"
  url "https://github.com/cern-it-sdc-id/davix.git",
      :tag      => "R_0_7_1",
      :revision => "414d90721a729c6d1bc6866feebddfc4e2fd4caa"
  version "0.7.1"
  head "https://github.com/cern-it-sdc-id/davix.git"



  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "python@2" => :build
  depends_on "openssl"
  depends_on "ossp-uuid"

  def install
    ENV.libcxx

    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/davix-get", "https://www.google.com"
  end
end
