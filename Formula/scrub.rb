class Scrub < Formula
  desc "Writes patterns on magnetic media to thwart data recovery"
  homepage "https://code.google.com/archive/p/diskscrub/"
  url "https://github.com/chaos/scrub/releases/download/2.6.1/scrub-2.6.1.tar.gz"
  mirror "https://mirrors.ocf.berkeley.edu/debian/pool/main/s/scrub/scrub_2.6.1.orig.tar.gz"
  sha256 "43d98d3795bc2de7920efe81ef2c5de4e9ed1f903c35c939a7d65adc416d6cb8"



  head do
    url "https://github.com/chaos/scrub.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    path = testpath/"foo.txt"
    path.write "foo"

    output = shell_output("#{bin}/scrub -r -p dod #{path}")
    assert_match "scrubbing #{path}", output
    refute_predicate path, :exist?
  end
end
