class Catimg < Formula
  desc "Insanely fast image printing in your terminal"
  homepage "https://github.com/posva/catimg"
  url "https://github.com/posva/catimg/archive/2.5.0.tar.gz"
  sha256 "8bbeeb18d4a5531dd8b86b130cc823cb9d0942f7b6e7013de70c251259a3a922"
  head "https://github.com/posva/catimg.git"



  depends_on "cmake" => :build

  def install
    system "cmake", "-DMAN_OUTPUT_PATH=#{man1}", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/catimg", test_fixtures("test.png")
  end
end
