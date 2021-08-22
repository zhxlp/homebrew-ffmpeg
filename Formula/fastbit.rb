class Fastbit < Formula
  desc "Open-source data processing library in NoSQL spirit"
  homepage "https://sdm.lbl.gov/fastbit/"
  url "https://code.lbl.gov/frs/download.php/file/426/fastbit-2.0.3.tar.gz"
  sha256 "1ddb16d33d869894f8d8cd745cd3198974aabebca68fa2b83eb44d22339466ec"



  depends_on "java"

  conflicts_with "iniparser", :because => "Both install `include/dictionary.h`"

  # Fix compilation with Xcode 9, reported by email on 2018-03-13
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/fe9d4e5/fastbit/xcode9.patch"
    sha256 "e1198caf262a125d2216d70cfec80ebe98d122760ffa5d99d34fc33646445390"
  end

  def install
    ENV.cxx11
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
    libexec.install lib/"fastbitjni.jar"
    bin.write_jar_script libexec/"fastbitjni.jar", "fastbitjni"
  end

  test do
    assert_equal prefix.to_s,
                 shell_output("#{bin}/fastbit-config --prefix").chomp
    (testpath/"test.csv").write <<~EOS
      Potter,Harry
      Granger,Hermione
      Weasley,Ron
    EOS
    system bin/"ardea", "-d", testpath,
           "-m", "a:t,b:t", "-t", testpath/"test.csv"
  end
end
