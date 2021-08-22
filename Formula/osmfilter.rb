class Osmfilter < Formula
  desc "Command-line tool to filter OpenStreetMap files for specific tags"
  homepage "https://wiki.openstreetmap.org/wiki/Osmfilter"
  url "https://gitlab.com/osm-c-tools/osmctools.git",
      :tag      => "0.9",
      :revision => "f341f5f237737594c1b024338f0a2fc04fabdff3"
  head "https://gitlab.com/osm-c-tools/osmctools.git"



  depends_on "autoconf" => :build
  depends_on "automake" => :build

  resource "pbf" do
    url "https://download.gisgraphy.com/openstreetmap/pbf/AD.tar.bz2"
    sha256 "403d74dd62f7cc59c044965c52e0e0cb8dcf2c01faa205a668e94d7258d89ad1"
  end

  def install
    system "autoreconf", "-v", "-i"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    resource("pbf").stage do
      system bin/"osmconvert", "AD", "-o=test.o5m"
      system bin/"osmfilter", "test.o5m",
        "--drop-relations", "--drop-ways", "--drop-nodes"
    end
  end
end
