class MecabUnidic < Formula
  desc "Morphological analyzer for MeCab"
  homepage "https://osdn.net/projects/unidic/"
  # Canonical: https://osdn.net/dl/unidic/unidic-mecab-2.1.2_src.zip
  url "https://dotsrc.dl.osdn.net/osdn/unidic/58338/unidic-mecab-2.1.2_src.zip"
  sha256 "6cce98269214ce7de6159f61a25ffc5b436375c098cc86d6aa98c0605cbf90d4"



  depends_on "mecab"

  link_overwrite "lib/mecab/dic"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-dicdir=#{lib}/mecab/dic/unidic"
    system "make", "install"
  end

  def caveats
    <<~EOS
      To enable mecab-unidic dictionary, add to #{HOMEBREW_PREFIX}/etc/mecabrc:
        dicdir = #{HOMEBREW_PREFIX}/lib/mecab/dic/unidic
    EOS
  end

  test do
    (testpath/"mecabrc").write <<~EOS
      dicdir = #{HOMEBREW_PREFIX}/lib/mecab/dic/unidic
    EOS

    pipe_output("mecab --rcfile=#{testpath}/mecabrc", "すもももももももものうち\n", 0)
  end
end
