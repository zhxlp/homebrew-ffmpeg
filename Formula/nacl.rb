class Nacl < Formula
  desc "Network communication, encryption, decryption, signatures library"
  homepage "https://nacl.cr.yp.to/"
  url "https://hyperelliptic.org/nacl/nacl-20110221.tar.bz2"
  mirror "https://deb.debian.org/debian/pool/main/n/nacl/nacl_20110221.orig.tar.bz2"
  sha256 "4f277f89735c8b0b8a6bbd043b3efb3fa1cc68a9a5da6a076507d067fc3b3bf8"



  def install
    # Print the build to stdout rather than the default logfile.
    # Logfile makes it hard to debug and spot hangs. Applied by Debian:
    # https://sources.debian.net/src/nacl/20110221-4.1/debian/patches/output-while-building/
    # Also, like Debian, inreplace the hostname because it isn't used outside
    # build process and adds an unpredictable factor.
    inreplace "do" do |s|
      s.gsub! 'exec >"$top/log"', 'exec | tee "$top/log"'
      s.gsub! /^shorthostname=`.*$/, "shorthostname=brew"
    end

    system "./do" # This takes a while since it builds *everything*

    # NaCL has an odd compilation model and installs the resulting
    # binaries in a directory like:
    #    <nacl source>/build/<hostname>/lib/<arch>/libnacl.a
    #    <nacl source>/build/<hostname>/include/<arch>/crypto_box.h
    #
    # It also builds both x86 and x86_64 copies if your compiler can
    # handle it, but we install only one.
    archstr = "amd64"

    # Don't include cpucycles.h
    include.install Dir["build/brew/include/#{archstr}/crypto_*.h"]
    include.install "build/brew/include/#{archstr}/randombytes.h"

    # Add randombytes.o to the libnacl.a archive - I have no idea why it's separated,
    # but plenty of the key generation routines depend on it. Users shouldn't have to
    # know this.
    nacl_libdir = "build/brew/lib/#{archstr}"
    system "ar", "-r", "#{nacl_libdir}/libnacl.a", "#{nacl_libdir}/randombytes.o"
    lib.install "#{nacl_libdir}/libnacl.a"
  end
end
