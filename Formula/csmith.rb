class Csmith < Formula
  desc "Generates random C programs conforming to the C99 standard"
  homepage "https://embed.cs.utah.edu/csmith/"
  url "https://embed.cs.utah.edu/csmith/csmith-2.3.0.tar.gz"
  sha256 "f247cc0aede5f8a0746271b40a5092b5b5a2d034e5e8f7a836c879dde3fb65d5"
  head "https://github.com/csmith-project/csmith.git"



  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
    mv "#{bin}/compiler_test.in", share
    (include/"csmith-#{version}/runtime").install Dir["runtime/*.h"]
  end

  def caveats; <<~EOS
    It is recommended that you set the environment variable 'CSMITH_PATH' to
      #{include}/csmith-#{version}
  EOS
  end

  test do
    system "#{bin}/csmith", "-o", "test.c"
  end
end
