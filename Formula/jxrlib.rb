class Jxrlib < Formula
  desc "Tools for JPEG-XR image encoding/decoding"
  homepage "https://archive.codeplex.com/?p=jxrlib"
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/j/jxrlib/jxrlib_1.1.orig.tar.gz"
  mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/j/jxrlib/jxrlib_1.1.orig.tar.gz"
  sha256 "c7287b86780befa0914f2eeb8be2ac83e672ebd4bd16dc5574a36a59d9708303"



  def install
    system "make"
    # The current stable release (1.1) doesn't have a make 'install' target
    lib.install %w[libjxrglue.a libjpegxr.a]
    bin.install %w[JxrEncApp JxrDecApp]
    include.install %w[common image]
    include.install "jxrgluelib" => "glue"
    include.install "jxrtestlib" => "test"
    doc.install Dir["doc/*"]
  end

  test do
    bmp = "Qk06AAAAAAAAADYAAAAoAAAAAQAAAAEAAAABABgAAAAAAAQAAADDDgAAww4AAAAAAAAAAAAA////AA==".unpack("m")[0]
    infile  = "test.bmp"
    outfile = "test.jxr"
    File.open(infile, "wb") { |f| f.write bmp }
    system bin/"JxrEncApp", "-i", infile,  "-o", outfile
    system bin/"JxrDecApp", "-i", outfile, "-o", infile
  end
end
