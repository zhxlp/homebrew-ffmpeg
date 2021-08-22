class Jumanpp < Formula
  desc "Japanese Morphological Analyzer based on RNNLM"
  homepage "http://nlp.ist.i.kyoto-u.ac.jp/EN/index.php?JUMAN%2B%2B"
  url "https://lotus.kuee.kyoto-u.ac.jp/nl-resource/jumanpp/jumanpp-1.02.tar.xz"
  sha256 "01fa519cb1b66c9cccc9778900a4048b69b718e190a17e054453ad14c842e690"



  depends_on "boost-build" => :build
  depends_on "boost"
  depends_on "gperftools"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    ENV["LANG"] = "C.UTF-8" # prevent "invalid byte sequence in UTF-8" on sierra build
    system bin/"jumanpp", "--version"

    output = <<~EOS
      こんにち こんにち こんにち 名詞 6 時相名詞 10 * 0 * 0 "代表表記:今日/こんにち カテゴリ:時間"
      は は は 助詞 9 副助詞 2 * 0 * 0 NIL
    EOS

    assert_match output, pipe_output(bin/"jumanpp", "echo こんにちは")
  end
end
