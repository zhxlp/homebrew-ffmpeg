class Yydecode < Formula
  desc "Decode yEnc archives"
  homepage "https://yydecode.sourceforge.io"
  url "https://downloads.sourceforge.net/project/yydecode/yydecode/0.2.10/yydecode-0.2.10.tar.gz"
  sha256 "bd4879643f6539770fd23d1a51dc6a91ba3de2823cf14d047a40c630b3c7ba66"



  def install
    # Redefinition of type found in 10.13 system headers
    # https://sourceforge.net/p/yydecode/bugs/5/
    if DevelopmentTools.clang_build_version >= 900
      inreplace "src/crc32.h", "typedef unsigned long int u_int32_t;", ""
    end

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end
end
