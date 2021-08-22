class Mdxmini < Formula
  desc "Plays music in X68000 MDX chiptune format"
  homepage "https://clogging.web.fc2.com/psp/"
  url "https://github.com/mistydemeo/mdxmini/archive/v1.0.0.tar.gz"
  sha256 "5a407203f35d873c3cd5977213b0c33a1ce283d6b14483e9d434de79b05ca4e2"



  depends_on "sdl"

  resource "test_song" do
    url "https://ftp.modland.com/pub/modules/MDX/-%20unknown/Popful%20Mail/pop-00.mdx"
    sha256 "86f21fbbaf93eb60e79fa07c759b906a782afe4e1db5c7e77a1640e6bf63fd14"
  end

  def install
    # Specify Homebrew's cc
    inreplace "mak/general.mak", "gcc", ENV.cc
    system "make"

    # Makefile doesn't build a dylib
    system ENV.cc, "-dynamiclib", "-install_name", "#{lib}/libmdxmini.dylib",
                   "-o", "libmdxmini.dylib", "-undefined", "dynamic_lookup",
                   *Dir["obj/*"]

    bin.install "mdxplay"
    lib.install "libmdxmini.dylib"
    (include/"libmdxmini").install Dir["src/*.h"]
  end

  test do
    resource("test_song").stage testpath
    (testpath/"mdxtest.c").write <<~EOS
      #include <stdio.h>
      #include "libmdxmini/mdxmini.h"

      int main(int argc, char** argv)
      {
          t_mdxmini mdx;
          char title[100];
          mdx_open(&mdx, argv[1], argv[2]);
          mdx_get_title(&mdx, title);
          printf("%s\\n", title);
      }
    EOS
    system ENV.cc, "mdxtest.c", "-L#{lib}", "-lmdxmini", "-o", "mdxtest"

    result = shell_output("#{testpath}/mdxtest #{testpath}/pop-00.mdx #{testpath}").chomp
    result.force_encoding("ascii-8bit") if result.respond_to? :force_encoding

    # Song title is in Shift-JIS
    # Trailing whitespace is intentional & shouldn't be removed.
    l1 = "\x82\xDB\x82\xC1\x82\xD5\x82\xE9\x83\x81\x83C\x83\x8B         "
    l2 = "\x83o\x83b\x83N\x83A\x83b\x83v\x8D\xEC\x90\xAC          "
    expected = <<~EOS
      #{l1}
      #{l2}
      (C)Falcom 1992 cv.\x82o\x82h. ass.\x82s\x82`\x82o\x81{
    EOS
    expected.force_encoding("ascii-8bit") if result.respond_to? :force_encoding
    assert_equal expected.delete!("\n"), result
  end
end
