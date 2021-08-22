class Bwfmetaedit < Formula
  desc "Tool for embedding, validating, and exporting BWF file metadata"
  homepage "https://mediaarea.net/BWFMetaEdit"
  url "https://mediaarea.net/download/binary/bwfmetaedit/1.3.6/BWFMetaEdit_CLI_1.3.6_GNU_FromSource.tar.bz2"
  version "1.3.6"
  sha256 "1223de41f55fd7c33c9bb398a3af33c0f0bd0c1c9ee1add17175f15abd6d95d0"



  def install
    cd "Project/GNU/CLI" do
      system "./configure",  "--disable-debug", "--prefix=#{prefix}"
      system "make", "install"
    end
  end

  test do
    pipe_output("#{bin}/bwfmetaedit --out-tech", test_fixtures("test.wav"))
  end
end
