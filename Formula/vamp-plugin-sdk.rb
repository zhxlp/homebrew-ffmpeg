class VampPluginSdk < Formula
  desc "Audio processing plugin system sdk"
  homepage "https://www.vamp-plugins.org/"
  url "https://code.soundsoftware.ac.uk/attachments/download/2206/vamp-plugin-sdk-2.7.1.tar.gz"
  sha256 "c6fef3ff79d2bf9575ce4ce4f200cbf219cbe0a21cfbad5750e86ff8ae53cb0b"
  head "https://code.soundsoftware.ac.uk/hg/vamp-plugin-sdk", :using => :hg



  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "flac"
  depends_on "libogg"
  depends_on "libsndfile"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include "vamp-sdk/Plugin.h"
      #include <vamp-sdk/PluginAdapter.h>

      class MyPlugin : public Vamp::Plugin { };

      const VampPluginDescriptor *
      vampGetPluginDescriptor(unsigned int version, unsigned int index) { return NULL; }
    EOS

    system ENV.cxx, "test.cpp", "-I#{include}", "-Wl,-dylib", "-o", "test.dylib"
    assert_match /Usage:/, shell_output("#{bin}/vamp-rdf-template-generator 2>&1", 2)

    cp "#{lib}/vamp/vamp-example-plugins.so", testpath/"vamp-example-plugins.dylib"
    ENV["VAMP_PATH"]=testpath
    assert_match /amplitudefollower/, shell_output("#{bin}/vamp-simple-host -l")
  end
end
