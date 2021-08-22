class Drafter < Formula
  desc "Native C/C++ API Blueprint Parser"
  homepage "https://apiblueprint.org/"
  url "https://github.com/apiaryio/drafter/releases/download/v3.2.7/drafter-v3.2.7.tar.gz"
  sha256 "a2b7061e2524804f153ac2e80f6367ae65dfcd367f4ee406eddecc6303f7f7ef"
  head "https://github.com/apiaryio/drafter.git"



  depends_on "cmake" => :build

  def install
    if build.head?
      system "cmake", ".", *std_cmake_args
      system "make"
    else
      system "./configure"
    end
    system "make", "install", "DESTDIR=#{prefix}"
  end

  test do
    (testpath/"api.apib").write <<~EOS
      # Homebrew API [/brew]

      ## Retrieve All Formula [GET /Formula]
      + Response 200 (application/json)
        + Attributes (array)
    EOS
    assert_equal "OK.", shell_output("#{bin}/drafter -l api.apib 2>&1").strip
  end
end
