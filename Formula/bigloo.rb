class Bigloo < Formula
  desc "Scheme implementation with object system, C, and Java interfaces"
  homepage "https://www-sop.inria.fr/indes/fp/Bigloo/"
  url "ftp://ftp-sop.inria.fr/indes/fp/Bigloo/bigloo4.3c.tar.gz"
  version "4.3c"
  sha256 "1f9557fccf9c17a83fcef458384f2fd748b42777aefa8370cd657ed33b7ccef2"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  depends_on "gmp"
  depends_on "openssl"

  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --prefix=#{prefix}
      --mandir=#{man1}
      --infodir=#{info}
      --customgc=yes
      --os-macosx
      --native=yes
      --disable-alsa
      --disable-mpg123
      --disable-flac
      --disable-srfi27
      --jvm=yes
    ]

    system "./configure", *args

    # bigloo seems to either miss installing these dependencies, or maybe
    # do it out of order with where they're used.
    cd "libunistring" do
      system "make", "install"
    end
    cd "pcre" do
      system "make", "install"
    end

    system "make"
    system "make", "install"

    # Install the other manpages too
    manpages = %w[bgldepend bglmake bglpp bgltags bglafile bgljfile bglmco bglprof]
    manpages.each { |m| man1.install "manuals/#{m}.man" => "#{m}.1" }
  end

  test do
    program = <<~EOS
      (display "Hello World!")
      (newline)
      (exit)
    EOS
    assert_match "Hello World!\n", pipe_output("#{bin}/bigloo -i -", program)
  end
end
