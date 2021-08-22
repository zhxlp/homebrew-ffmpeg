class Snownews < Formula
  desc "Text mode RSS newsreader"
  homepage "https://github.com/kouya/snownews"
  url "https://github.com/kouya/snownews/archive/v1.5.13.tar.gz"
  sha256 "9a06cd58dee7846cbb18166c3b60153c1b7ee963261b205633d77feaa5410455"



  depends_on "gettext"
  depends_on "openssl"

  def install
    # Fix file not found errors for /usr/lib/system/libsystem_symptoms.dylib and
    # /usr/lib/system/libsystem_darwin.dylib on 10.11 and 10.12, respectively
    if MacOS.version == :sierra || MacOS.version == :el_capitan
      ENV["SDKROOT"] = MacOS.sdk_path
    end

    system "./configure", "--prefix=#{prefix}"

    # Must supply -lz because configure relies on "xml2-config --libs"
    # for it, which doesn't work on OS X prior to 10.11
    system "make", "install", "EXTRA_LDFLAGS=#{ENV.ldflags} -L#{Formula["openssl"].opt_lib} -lz", "CC=#{ENV.cc}"
  end
end
