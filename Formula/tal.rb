class Tal < Formula
  desc "Align line endings if they match"
  # The canonical url currently returns HTTP/1.1 500 Internal Server Error.
  homepage "https://web.archive.org/web/20160406172703/https://thomasjensen.com/software/tal/"
  url "https://www.mirrorservice.org/sites/download.salixos.org/x86_64/extra-14.2/source/misc/tal/tal-1.9.tar.gz"
  mirror "https://web.archive.org/web/20160406172703/https://thomasjensen.com/software/tal/tal-1.9.tar.gz"
  sha256 "5d450cee7162c6939811bca945eb475e771efe5bd6a08b520661d91a6165bb4c"



  def install
    system "make", "linux"
    bin.install "tal"
    man1.install "tal.1"
  end

  test do
    system "#{bin}/tal", "/etc/passwd"
  end
end
