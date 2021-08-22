class MecabIpadic < Formula
  desc "IPA dictionary compiled for MeCab"
  homepage "https://taku910.github.io/mecab/"
  # Canonical url is https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/m/mecab-ipadic/mecab-ipadic_2.7.0-20070801+main.orig.tar.gz"
  mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/m/mecab-ipadic/mecab-ipadic_2.7.0-20070801+main.orig.tar.gz"
  version "2.7.0-20070801"
  sha256 "b62f527d881c504576baed9c6ef6561554658b175ce6ae0096a60307e49e3523"



  depends_on "mecab"

  link_overwrite "lib/mecab/dic"

  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --prefix=#{prefix}
      --with-charset=utf8
      --with-dicdir=#{lib}/mecab/dic/ipadic
    ]

    system "./configure", *args
    system "make", "install"
  end

  def caveats
    <<~EOS
      To enable mecab-ipadic dictionary, add to #{HOMEBREW_PREFIX}/etc/mecabrc:
        dicdir = #{HOMEBREW_PREFIX}/lib/mecab/dic/ipadic
    EOS
  end

  test do
    (testpath/"mecabrc").write <<~EOS
      dicdir = #{HOMEBREW_PREFIX}/lib/mecab/dic/ipadic
    EOS

    pipe_output("mecab --rcfile=#{testpath}/mecabrc", "すもももももももものうち\n", 0)
  end
end
