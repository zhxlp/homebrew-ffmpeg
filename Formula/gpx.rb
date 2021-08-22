class Gpx < Formula
  desc "Gcode to x3g converter for 3D printers running Sailfish"
  homepage "https://github.com/markwal/GPX/blob/master/README.md"
  url "https://github.com/markwal/GPX/archive/2.5.2.tar.gz"
  sha256 "8b637a366a2863ca3a11b4c6a33d8ebc10806bf7de3e3ac90f2a3a57529ea864"
  head "https://github.com/markwal/GPX.git"



  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.gcode").write("G28 X Y Z")
    system "#{bin}/gpx", "test.gcode"
  end
end
