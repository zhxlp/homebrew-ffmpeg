class Minicom < Formula
  desc "Menu-driven communications program"
  homepage "https://packages.debian.org/sid/minicom"
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/m/minicom/minicom_2.7.1.orig.tar.gz"
  mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/m/minicom/minicom_2.7.1.orig.tar.gz"
  sha256 "532f836b7a677eb0cb1dca8d70302b73729c3d30df26d58368d712e5cca041f1"



  def install
    # There is a silly bug in the Makefile where it forgets to link to iconv. Workaround below.
    ENV["LIBS"] = "-liconv"

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"

    (prefix/"etc").mkdir
    (prefix/"var").mkdir
    (prefix/"etc/minirc.dfl").write "pu lock #{prefix}/var\npu escape-key Escape (Meta)\n"
  end

  def caveats; <<~EOS
    Terminal Compatibility
    ======================
    If minicom doesn't see the LANG variable, it will try to fallback to
    make the layout more compatible, but uglier. Certain unsupported
    encodings will completely render the UI useless, so if the UI looks
    strange, try setting the following environment variable:

      LANG="en_US.UTF-8"

    Text Input Not Working
    ======================
    Most development boards require Serial port setup -> Hardware Flow
    Control to be set to "No" to input text.
  EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/minicom -v", 1)
  end
end
