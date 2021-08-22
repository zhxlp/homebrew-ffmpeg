class Readosm < Formula
  desc "Extract valid data from an Open Street Map input file"
  homepage "https://www.gaia-gis.it/fossil/readosm/index"
  url "https://www.gaia-gis.it/gaia-sins/readosm-1.1.0.tar.gz"
  sha256 "c508cde9c49b955613d9a30dcf622fa264a5c0e01f58074e93351ea39abd40ec"



  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
    doc.install "examples"
  end

  test do
    system ENV.cc, "-I#{include}", "-L#{lib}", "-lreadosm",
           doc/"examples/test_osm1.c", "-o", testpath/"test"
    assert_equal "usage: test_osm1 path-to-OSM-file",
                 shell_output("./test 2>&1", 255).chomp
  end
end
