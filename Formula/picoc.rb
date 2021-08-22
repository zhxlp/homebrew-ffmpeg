class Picoc < Formula
  desc "C interpreter for scripting"
  homepage "https://github.com/zsaleeba/picoc"
  revision 1
  head "https://github.com/zsaleeba/picoc.git"

  stable do
    url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/picoc/picoc-2.1.tar.bz2"
    mirror "https://dl.bintray.com/homebrew/mirror/picoc-2.1.tar.bz2"
    sha256 "bfed355fab810b337ccfa9e3215679d0b9886c00d9cb5e691f7e7363fd388b7e"

    # Remove for > 2.1
    # Fix abort trap due to stack overflow
    # Upstream commit from 14 Oct 2013 "Fixed a problem with PlatformGetLine()"
    patch do
      url "https://github.com/zsaleeba/picoc/commit/ed54c51.patch?full_index=1"
      sha256 "2111ad8d038cf0063430746bf868b56f4658e79b87e4b94b03d00fb58af8564f"
    end
  end



  def install
    system "make", "CC=#{ENV.cc}", "CFLAGS=#{ENV.cflags} -DUNIX_HOST"
    bin.install "picoc"
  end

  test do
    (testpath/"brew.c").write <<~EOS
      #include <stdio.h>
      int main(void) {
        printf("Homebrew\n");
        return 0;
      }
    EOS
    assert_match "Homebrew", shell_output("#{bin}/picoc brew.c")
  end
end
