class LibunwindHeaders < Formula
  desc "C API for determining the call-chain of a program"
  homepage "https://opensource.apple.com/"
  url "https://opensource.apple.com/tarballs/libunwind/libunwind-35.3.tar.gz"
  sha256 "2bcc95553a44fa3edca41993ccfac65ba267830cb37c85dca760b34094722e56"



  keg_only :provided_by_macos,
    "this formula includes official development headers not installed by Apple"

  def install
    include.install Dir["include/*"]
    (include/"libunwind").install Dir["src/*.h*"]
    (include/"libunwind/libunwind_priv.h").unlink
  end
end
