class Postmark < Formula
  desc "File system benchmark from NetApp"
  homepage "https://packages.debian.org/sid/postmark"
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/p/postmark/postmark_1.53.orig.tar.gz"
  mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/p/postmark/postmark_1.53.orig.tar.gz"
  sha256 "8a88fd322e1c5f0772df759de73c42aa055b1cd36cbba4ce6ee610ac5a3c47d3"



  def install
    system ENV.cc, "-o", "postmark", "postmark-#{version}.c"
    bin.install "postmark"
    man1.install "postmark.1"
  end

  test do
    (testpath/"config").write <<~EOS
      set transactions 50
      set location #{testpath}
      run
    EOS

    output = pipe_output("#{bin}/postmark #{testpath}/config")
    assert_match /(50 per second)/, output
  end
end
